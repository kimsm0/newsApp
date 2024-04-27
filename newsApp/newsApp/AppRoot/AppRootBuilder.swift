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
import CombineSchedulers

protocol AppRootDependency: Dependency { }

final class AppRootComponent: Component<AppRootDependency>, NewsMainDependency {
    var mainQueue: AnySchedulerOf<DispatchQueue> {
        .main
    }
    var newsRepository: NewsRepository
    
    override init(dependency: AppRootDependency) {
        #if UITESTING
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [AppURLProtocol.self]
        setupURLProtocol()
        #else        
        let config = URLSessionConfiguration.default
        #endif
        let network = NetworkImp(session: URLSession(configuration: config))                
        
        self.newsRepository = NewsRepositoryImp(network: network, baseURL: URL(string: API().baseURL)!)
        
        
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
            dependency: dependency
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
