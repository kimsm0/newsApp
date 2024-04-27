
/**
 @class WebViewRouter
 @date 4/27/24
 @writer kimsoomin
 @brief
 @update history
 -
 */
import ModernRIBs

protocol WebViewInteractable: Interactable {
    var router: WebViewRouting? { get set }
    var listener: WebViewListener? { get set }
}

protocol WebViewViewControllable: ViewControllable {
    
}

final class WebViewRouter: ViewableRouter<WebViewInteractable, WebViewViewControllable>, WebViewRouting {
    
    override init(interactor: WebViewInteractable, viewController: WebViewViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
