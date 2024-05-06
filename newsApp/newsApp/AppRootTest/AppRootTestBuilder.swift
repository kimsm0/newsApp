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
import NewsMain
import NewsDetail
import NewsRepository
import CombineSchedulers
import Network

protocol AppRootTestDependency: Dependency { }

final class AppRootTestComponent: Component<AppRootTestDependency>, NewsMainDependency, NewsDetailDependency {
    var mainQueue: AnySchedulerOf<DispatchQueue> {
        .main
    }
    var newsRepository: NewsRepository
    
    override init(dependency: AppRootTestDependency) {
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

final class AppRootTestBuilder: Builder<AppRootTestDependency>, AppRootBuildable {

    override init(dependency: AppRootTestDependency) {
        super.init(dependency: dependency)
    }

    func build() -> LaunchRouting {
        let viewController = AppRootController()
        
        let component = AppRootTestComponent(
            dependency: dependency
        )
                
        let interactor = AppRootTestInteractor(presenter: viewController)
                 
        //하위 리블렛의 빌더 생성
        let newsMainBuildable = NewsMainBuilder(dependency: component)
        let newsDetailBuildable = NewsDetailBuilder(dependency: component)
        
        
        let router = AppRootTestRouter(
            interactor: interactor,
            viewController: viewController,
            newsMainBuildable: newsMainBuildable,
            newsDetailBuildable: newsDetailBuildable
        )
        return router
    }
}
