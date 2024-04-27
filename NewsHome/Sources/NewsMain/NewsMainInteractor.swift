/**
 @class NewsMainInteractor
 @date 4/21/24
 @writer kimsoomin
 @brief
 @update history
 -
 */
import Foundation
import Combine
import ModernRIBs
import NewsRepository
import NewsDataModel
import Common
import CombineSchedulers

protocol NewsMainRouting: ViewableRouting {
    func attachNewsDetail(selectedIndex: Int)
    func detachNewsDetail()
}

protocol NewsMainPresentable: Presentable {
    var listener: NewsMainPresentableListener? { get set }
    func update(with dataSource: [ArticleEntity])
    func scrollToLastArticle(index: Int)
    func showAlert(message: String)
}

public protocol NewsMainListener: AnyObject {    
}

protocol NewsMainInteractorDependency {
    var newsRepository: NewsRepository { get }
    var mainQueue: AnySchedulerOf<DispatchQueue> { get }
}

final class NewsMainInteractor: PresentableInteractor<NewsMainPresentable>, NewsMainInteractable {

    weak var router: NewsMainRouting?
    weak var listener: NewsMainListener?

    private let depengency: NewsMainInteractorDependency
    private var subscription: Set<AnyCancellable>
    
    private var curPage = 1
    
    init(presenter: NewsMainPresentable,
         depengency: NewsMainInteractorDependency
    ) {
        self.subscription = .init()
        self.depengency = depengency
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        bind()
        fetchNewsList()
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func bind(){
        depengency.newsRepository.articleTotalResult
            .receive(on: depengency.mainQueue)
            .dropFirst()
            .sink {[weak self] total in
                self?.presenter.update(with: total.articles)
            }.store(in: &subscription)
        
        depengency.newsRepository.resultError
            .receive(on: depengency.mainQueue)
            .sink {[weak self] error in
                if let self, let error {
                    self.presenter.showAlert(message: "에러가 발생했습니다.\n잠시후 다시 시도해주세요.\(error.customCode)")
                }
            }.store(in: &subscription)
    }
}

extension NewsMainInteractor {
    /**
     @brief API호출
     */
    private func fetchNewsList(){
        depengency.newsRepository.fetchArticles(curPage: curPage)
    }
}

extension NewsMainInteractor: NewsMainPresentableListener {
    /**
     @brief 메인화면에서 기사를 선택했을 때, Detail 리블렛 attach
     presenter -> interator
     */
    func didSelectArticle(index: Int) {
        if let _ = depengency.newsRepository.articleTotalResult.value.articles[safe: index] {
            router?.attachNewsDetail(selectedIndex: index)
        }
    }
        
    /**
     @brief presenter에서 scroll down시, 페이징 처리를 하기 위해 호출됨.
     - 로드할 데이터가 남아 있는 경우, API 호출
     */
    func loadMore(index: Int) {
        let curValue = depengency.newsRepository.articleTotalResult.value
        if curValue.totalResults > curValue.articles.count {
            curPage += 1
            fetchNewsList()
        }
    }
}

// MARK: NewsDetailListener
// 하위 리블렛의 인터렉터에서 listener로 호출.
extension NewsMainInteractor {
    /**
     @brief 하위 detail리블렛에서 navigation back 버튼으로 화면 이탈시, 하위 리블렛 detach 진행
     - lastArticleIndex 하위리블렛의 기사 index를 받아, 메인의 스크롤 위치를 조정한다.
     */
    func detachNewsDetail(lastArticleIndex: Int) {
        router?.detachNewsDetail()
        presenter.scrollToLastArticle(index: lastArticleIndex)
    }
    /**
     @brief 하위 detail리블렛에서 하단 next 버튼 탭시 호출.
     - 로드할 데이터가 남아 있는 경우, API 호출
     */
    func loadMoreFromDetail() {
        let curValue = depengency.newsRepository.articleTotalResult.value
        if curValue.totalResults > curValue.articles.count {
            curPage += 1
            fetchNewsList()
        }
    }
}
