/**
 @class NewsMainInteractor
 @date 4/21/24
 @writer kimsoomin
 @brief
 @update history
 -
 */

import ModernRIBs

protocol NewsMainRouting: ViewableRouting {
}

protocol NewsMainPresentable: Presentable {
    var listener: NewsMainPresentableListener? { get set }
}

protocol NewsMainListener: AnyObject {
}

final class NewsMainInteractor: PresentableInteractor<NewsMainPresentable>, NewsMainInteractable, NewsMainPresentableListener {

    weak var router: NewsMainRouting?
    weak var listener: NewsMainListener?

   
    override init(presenter: NewsMainPresentable) {
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
