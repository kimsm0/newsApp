/**
 @class NewsDetailInteractor
 @date 4/21/24
 @writer kimsoomin
 @brief
 @update history
 -
 */
import ModernRIBs

protocol NewsDetailRouting: ViewableRouting {
}

protocol NewsDetailPresentable: Presentable {
    var listener: NewsDetailPresentableListener? { get set }
}

public protocol NewsDetailListener: AnyObject {
    func detachNewsDetail()
}

final class NewsDetailInteractor: PresentableInteractor<NewsDetailPresentable>, NewsDetailInteractable, NewsDetailPresentableListener {

    weak var router: NewsDetailRouting?
    weak var listener: NewsDetailListener?

   
    override init(presenter: NewsDetailPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()
    }
}

extension NewsDetailInteractor {
    func didTapBackButton() {
        listener?.detachNewsDetail()
    }
}
