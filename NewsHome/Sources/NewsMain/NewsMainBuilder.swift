/**
 @class NewsMainBuilder
 @date 4/21/24
 @writer kimsoomin
 @brief
 @update history
 -
 */
import Foundation
import ModernRIBs
import NewsRepository
import NewsDetail
import NewsDataModel
import CombineSchedulers

public protocol NewsMainDependency: Dependency {
    var newsRepository: NewsRepository { get }
    var mainQueue: AnySchedulerOf<DispatchQueue> { get }
}

final class NewsMainComponent: Component<NewsMainDependency>, NewsMainInteractorDependency, NewsDetailDependency {
    
    var newsRepository: NewsRepository{
        dependency.newsRepository
    }
    var mainQueue: AnySchedulerOf<DispatchQueue>{
        dependency.mainQueue
    }
}

// MARK: - Builder
public protocol NewsMainBuildable: Buildable {
    func build(withListener listener: NewsMainListener) -> ViewableRouting
}

public final class NewsMainBuilder: Builder<NewsMainDependency>, NewsMainBuildable {
    public override init(dependency: NewsMainDependency) {
        super.init(dependency: dependency)
    }

    public  func build(withListener listener: NewsMainListener) -> ViewableRouting {
        
        let component = NewsMainComponent(dependency: dependency)
        let viewController = NewsMainViewController()
                
        let interactor = NewsMainInteractor(
            presenter: viewController,
            depengency: component
        )
        interactor.listener = listener
        
        let newsDetailBuildable = NewsDetailBuilder(dependency: component)
        
        return NewsMainRouter(interactor: interactor,
                              viewController: viewController,
                              newsDetailBuildable: newsDetailBuildable)
    }
}
