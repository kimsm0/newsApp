/**
 @class
 @date
 @writer kimsoomin
 @brief
 @update history
 -
 */

import ModernRIBs
import Extensions
import NewsMain

protocol AppRootInteractable: Interactable, NewsMainListener {
    var router: AppRootRouting? { get set }
    var listener: AppRootListener? { get set }
}

protocol AppRootViewControllable: ViewControllable {
    func setViewController(_ viewController: ViewControllable)
}

final class AppRootRouter: LaunchRouter<AppRootInteractable, AppRootViewControllable>, AppRootRouting {
    
    private let newsMainBuildable: NewsMainBuildable
    private var newsMainRouting: ViewableRouting?
    
    init(interactor: AppRootInteractable,
                  viewController: AppRootViewControllable,
                  newsMainBuildable: NewsMainBuildable
    ) {
        self.newsMainBuildable = newsMainBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

extension AppRootRouter {
    func attachNewsMain() {
        //Ribs 트리를 만들어서 각 리블렛들의 레퍼런스를 유지하고, 인터렉터의 라이프 사이클 관련 메소드를 호출하는 작업.
        if newsMainRouting == nil {
            let router = newsMainBuildable.build(withListener: interactor)
            newsMainRouting = router
            attachChild(router)
            
            //뷰컨을 띄우는 작업.
            //uikit을 숨기고 싶어서 한 번 감싼 뷰컨 viewControllable 프로퍼티.
            viewController.setViewController(router.viewControllable)
        }
    }
}
