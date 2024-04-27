/**
 @class NewsDetailRouter
 @date 4/21/24
 @writer kimsoomin
 @brief
 @update history
 -
 */
import ModernRIBs
import WebView

protocol NewsDetailInteractable: Interactable, WebViewListener {
    var router: NewsDetailRouting? { get set }
    var listener: NewsDetailListener? { get set }
    
}

protocol NewsDetailViewControllable: ViewControllable {
}

final class NewsDetailRouter: ViewableRouter<NewsDetailInteractable, NewsDetailViewControllable>, NewsDetailRouting {
    
    private let webViewBuildable: WebViewBuildable
    private var webViewRouting: Routing?

    init(interactor: NewsDetailInteractable,
                  viewController: NewsDetailViewControllable,
                  webViewBuildable: WebViewBuildable
    ) {
        self.webViewBuildable = webViewBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

extension NewsDetailRouter {   
    
    func attachWebView(url: String) {
        if webViewRouting == nil && !url.isEmpty {
            let router = webViewBuildable.build(withListener: interactor, url: url)
            self.webViewRouting = router
            viewControllable.uiviewController.navigationController?.pushViewController(router.viewControllable.uiviewController, animated: true)
            attachChild(router)
        }
    }
    
    func detachWebView() {
        if let router = webViewRouting {
            self.viewController.uiviewController.navigationController?.popViewController(animated: true)
            detachChild(router)
            webViewRouting = nil
        }
    }
}
