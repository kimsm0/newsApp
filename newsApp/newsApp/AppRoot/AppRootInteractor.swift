/**
 @class
 @date
 @writer kimsoomin
 @brief
 @update history
 -
 */

import ModernRIBs

protocol AppRootRouting: LaunchRouting {
    func attachNewsMain()
}

protocol AppRootPresentable: Presentable {
    var listener: AppRootPresentableListener? { get set }
}

protocol AppRootListener: AnyObject {
}

final class AppRootInteractor: PresentableInteractor<AppRootPresentable>, AppRootInteractable, AppRootPresentableListener {

    weak var router: AppRootRouting?
    weak var listener: AppRootListener?

    override init(presenter: AppRootPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()   
        router?.attachNewsMain()
    }

    override func willResignActive() {
        super.willResignActive()
    }
}
