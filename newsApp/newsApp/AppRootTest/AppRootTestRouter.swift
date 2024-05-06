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
import NewsDetail

protocol AppRootTestInteractable: Interactable, NewsDetailListener, NewsMainListener {
    var router: AppRootTestRouting? { get set }
    var listener: AppRootTestListener? { get set }
}


final class AppRootTestRouter: LaunchRouter<AppRootTestInteractable, AppRootViewControllable>, AppRootTestRouting {    

    private let newsMainBuildable: NewsMainBuildable
    private var newsMainRouting: ViewableRouting?
    
    private let newsDetailBuildable: NewsDetailBuildable
    private var newsDetailRouting: ViewableRouting?
    
    init(interactor: AppRootTestInteractable,
         viewController: AppRootViewControllable,
         newsMainBuildable: NewsMainBuildable,
         newsDetailBuildable: NewsDetailBuildable
    ) {
        self.newsMainBuildable = newsMainBuildable
        self.newsDetailBuildable = newsDetailBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

extension AppRootTestRouter {
    func attachNewsMain() {
        if newsMainRouting == nil {
            let router = newsMainBuildable.build(withListener: interactor)
            newsMainRouting = router
            attachChild(router)
            viewController.setViewController(router.viewControllable)
        }
    }
    
    func attachNewsDetail() {
        if newsDetailRouting == nil {
            let router = newsDetailBuildable.build(
                withListener: interactor,
                startArticleIndex: 0
            )
            self.newsDetailRouting = router
            viewControllable.uiviewController.navigationController?.pushViewController(router.viewControllable.uiviewController, animated: true)
            attachChild(router)
        }
    }
    
    
}
