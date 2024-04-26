/**
 @class NewsDetailInteractor
 @date 4/21/24
 @writer kimsoomin
 @brief
 @update history
 -
 */
import Foundation
import ModernRIBs
import Combine
import NewsRepository
import NewsDataModel

protocol NewsDetailRouting: ViewableRouting {
}

protocol NewsDetailPresentable: Presentable {
    var listener: NewsDetailPresentableListener? { get set }
    func update(total: ArticleTotalEntity, startPageIndex: Int)
}

public protocol NewsDetailListener: AnyObject {
    func detachNewsDetail(lastArticleIndex: Int)
    func loadMoreFromDetail()
}

protocol NewsDetailInteractorDependency {
    var newsRepository: NewsRepository { get }
    var startPageIndex: Int { get }
}

final class NewsDetailInteractor: PresentableInteractor<NewsDetailPresentable>, NewsDetailInteractable {

    weak var router: NewsDetailRouting?
    weak var listener: NewsDetailListener?

    private let depengency: NewsDetailInteractorDependency
    private var subscription: Set<AnyCancellable>
           
    init(presenter: NewsDetailPresentable,
         depengency: NewsDetailInteractorDependency
    ) {
        self.subscription = .init()
        self.depengency = depengency
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        bind()
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func bind(){
        depengency.newsRepository.articleTotalResult
            .receive(on: DispatchQueue.main)
            .sink {[weak self] total in
                if let self {
                    self.presenter.update(
                        total: total,
                        startPageIndex: self.depengency.startPageIndex
                    )
                }
            }.store(in: &subscription)
    }
}

extension NewsDetailInteractor: NewsDetailPresentableListener {
    /**
     @brief presentor에서 navigation back 버튼 탭하면 호출
     - listener를 통해 상위 리블렛의 detach 메서드 호출 ( 현재 리블렛 detach는 상위 리블렛에서 진행 )
     */
    func didTapBackButton(index: Int) {
        listener?.detachNewsDetail(lastArticleIndex: index)
    }
    
    /**
     @brief presentor에서 하단 next 버튼 탭하면 호출
     - listener를 통해 상위 리블렛의 API요청 메서드 호출
     */
    func loadMoreFromDetail() {
        listener?.loadMoreFromDetail()
    }
}
