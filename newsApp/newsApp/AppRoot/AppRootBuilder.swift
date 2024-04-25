/**
 @class
 @date
 @writer kimsoomin
 @brief
 @update history
 -
 */
import UIKit
import ModernRIBs
import Combine
import Utils
import NewsMain
import Extensions
import NewsRepository
import Common
import Network

protocol AppRootDependency: Dependency { }

final class AppRootComponent: Component<AppRootDependency>, NewsMainDependency {
    var rootViewController: ViewControllable
    var newsRepository: NewsRepository
    init(
        dependency: AppRootDependency,
        rootViewController: ViewControllable
    ) {
        #if UITESTING
        let config = URLSessionConfiguration.default
        #else
        let config = URLSessionConfiguration.default
        #endif
        let network = NetworkImp(session: URLSession(configuration: config))
        
        self.rootViewController = rootViewController
        
        self.newsRepository = NewsRepositoryImp(network: network, baseURL: URL(string: API.baseURL)!)
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
        let viewController = AppRootController()
        
        let component = AppRootComponent(
            dependency: dependency,
            rootViewController: viewController
        )
        
        //2. 리블렛의 인터렉터
        let interactor = AppRootInteractor(presenter: viewController)
                 
        //하위 리블렛의 빌더 생성
        let newsMainBuildable = NewsMainBuilder(dependency: component)
        
        //3.리블렛의 라우터
        let router = AppRootRouter(
            interactor: interactor,
            viewController: viewController,
            newsMainBuildable: newsMainBuildable
        )
        
        return router
    }
}
