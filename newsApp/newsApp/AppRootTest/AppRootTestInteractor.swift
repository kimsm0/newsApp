/**
 @class
 @date
 @writer kimsoomin
 @brief
 @update history
 -
 */
import ModernRIBs
import NewsTestSupport

protocol AppRootTestRouting: ViewableRouting {
    func attachNewsMain()
    func attachNewsDetail()
}

protocol AppRootTestListener: AnyObject {
    
}

final class AppRootTestInteractor: PresentableInteractor<AppRootPresentable>, AppRootTestInteractable, AppRootPresentableListener {
    
    weak var router: AppRootTestRouting?
    weak var listener: AppRootTestListener?

    override init(presenter: AppRootPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        switch TestDouble.testMode {
        case.main:
            router?.attachNewsMain()
        case .detail:
            router?.attachNewsDetail()
        }
    }

    override func willResignActive() {
        super.willResignActive()
    }
}

extension AppRootTestInteractor {
    func detachNewsDetail(lastArticleIndex: Int) {
    }
    
    func loadMoreFromDetail() {
    }
}
