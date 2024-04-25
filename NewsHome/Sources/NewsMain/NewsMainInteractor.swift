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

protocol NewsMainRouting: ViewableRouting {
    func attachNewsDetail(selectedIndex: Int)
    func detachNewsDetail()
}

protocol NewsMainPresentable: Presentable {
    var listener: NewsMainPresentableListener? { get set }
    func update(with dataSource: [ArticleEntity])
}

public protocol NewsMainListener: AnyObject {
}

protocol NewsMainInteractorDependency {
    var newsRepository: NewsRepository { get }
}

final class NewsMainInteractor: PresentableInteractor<NewsMainPresentable>, NewsMainInteractable, NewsMainPresentableListener {

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
            .receive(on: DispatchQueue.main)
            .sink {[weak self] total in
                self?.presenter.update(with: total.articles)
            }.store(in: &subscription)
    }
}

extension NewsMainInteractor {
    func fetchNewsList(){
        let _ = depengency.newsRepository.fetchArticles(curPage: curPage)
    }
}

extension NewsMainInteractor {
    func didSelectArticle(index: Int) {        
        if let article = depengency.newsRepository.articleTotalResult.value.articles[safe: index] {
            router?.attachNewsDetail(selectedIndex: index)
        }
    }
    
    func detachNewsDetail() {
        router?.detachNewsDetail()
    }
    
    func loadMore(index: Int) {
        if depengency.newsRepository.articleTotalResult.value.totalResults > index {
            curPage += 1
            fetchNewsList()
        }
    }
}
