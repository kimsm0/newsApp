/**
 @class WebViewBuilder
 @date 4/27/24
 @writer kimsoomin
 @brief
 @update history
 -
 */
import ModernRIBs

public protocol WebViewDependency: Dependency {
    
}

final class WebViewComponent: Component<WebViewDependency> {
    
}

// MARK: - Builder

public protocol WebViewBuildable: Buildable {
    
    func build(withListener listener: WebViewListener,
               url: String
    ) -> ViewableRouting
}

public final class WebViewBuilder: Builder<WebViewDependency>, WebViewBuildable {

    public override init(dependency: WebViewDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: WebViewListener,
                      url: String
    ) -> ViewableRouting {
        
        let _ = WebViewComponent(dependency: dependency)
        let viewController = WebViewController(urlString: url)
        let interactor = WebViewInteractor(presenter: viewController)
        interactor.listener = listener
        return WebViewRouter(interactor: interactor, viewController: viewController)
    }
}
