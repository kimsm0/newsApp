/**
 @class
 @date
 @writer kimsoomin
 @brief
 @update history
 -
 */

import ModernRIBs
import Combine
import Utils


protocol AppRootDependency: Dependency { }

final class AppRootComponent: Component<AppRootDependency> {
    var rootViewController: ViewControllable
    
    init(
        dependency: AppRootDependency,
        rootViewController: ViewControllable
    ) {
        self.rootViewController = rootViewController
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol AppRootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class AppRootBuilder: Builder<AppRootDependency>, AppRootBuildable {

    override init(dependency: AppRootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> LaunchRouting {
        
        //1.리블렛의 뷰
        let viewController = AppRootTabBarController()
        
        let component = AppRootComponent(
            dependency: dependency,
            rootViewController: viewController
        )
        
        //2. 리블렛의 인터렉터
        let interactor = AppRootInteractor(presenter: viewController)
                       
        //3.리블렛의 라우터
        let router = AppRootRouter(
            interactor: interactor,
            viewController: viewController
        )
        
        return router
    }
}
