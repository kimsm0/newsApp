/**
 @class NewsDetailBuilder
 @date 4/21/24
 @writer kimsoomin
 @brief
 @update history
 -
 */
import ModernRIBs
import NewsDataModel
import NewsRepository

public protocol NewsDetailDependency: Dependency {
    var newsRepository: NewsRepository { get }
}

final class NewsDetailComponent: Component<NewsDetailDependency> {
    var newsRepository: NewsRepository {
        dependency.newsRepository
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
        
        let component = NewsDetailComponent(dependency: dependency)
        let viewController = NewsDetailViewController(startArticleIndex: startArticleIndex, totalArticles: dependency.newsRepository.articleTotalResult.value.articles)
        let interactor = NewsDetailInteractor(presenter: viewController)
        interactor.listener = listener
        return NewsDetailRouter(interactor: interactor, viewController: viewController)
    }
}
