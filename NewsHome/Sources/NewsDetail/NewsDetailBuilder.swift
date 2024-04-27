/**
 @class NewsDetailBuilder
 @date 4/21/24
 @writer kimsoomin
 @brief
 @update history
 -
 */
import Foundation
import ModernRIBs
import NewsDataModel
import NewsRepository
import CombineSchedulers

public protocol NewsDetailDependency: Dependency {
    var newsRepository: NewsRepository { get }
    var mainQueue: AnySchedulerOf<DispatchQueue> { get }
}

final class NewsDetailComponent: Component<NewsDetailDependency>, NewsDetailInteractorDependency {
    var newsRepository: NewsRepository {
        dependency.newsRepository
    }
    var mainQueue: AnySchedulerOf<DispatchQueue>{
        dependency.mainQueue
    }
    var startPageIndex: Int
    
    init(dependency: NewsDetailDependency,
         startPageIndex: Int
    ) {
        self.startPageIndex = startPageIndex
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

public protocol NewsDetailBuildable: Buildable {
    func build(withListener listener: NewsDetailListener, startArticleIndex: Int) -> ViewableRouting
}

public final class NewsDetailBuilder: Builder<NewsDetailDependency>, NewsDetailBuildable {
    
    public override init(dependency: NewsDetailDependency) {
        super.init(dependency: dependency)
    }
    
    public func build(withListener listener: NewsDetailListener,
                      startArticleIndex: Int
    ) -> ViewableRouting {
        
        let component = NewsDetailComponent(
            dependency: dependency,
            startPageIndex: startArticleIndex
        )
        
        let viewController = NewsDetailViewController()
        
        let interactor = NewsDetailInteractor(
            presenter: viewController,
            depengency: component
        )
        interactor.listener = listener
        return NewsDetailRouter(interactor: interactor, viewController: viewController)
    }
}
