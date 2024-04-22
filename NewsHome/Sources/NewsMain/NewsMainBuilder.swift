/**
 @class NewsMainBuilder
 @date 4/21/24
 @writer kimsoomin
 @brief
 @update history
 -
 */
import ModernRIBs

protocol NewsMainDependency: Dependency {
    
}

final class NewsMainComponent: Component<NewsMainDependency> {

}

// MARK: - Builder

protocol NewsMainBuildable: Buildable {
    func build(withListener listener: NewsMainListener) -> NewsMainRouting
}

final class NewsMainBuilder: Builder<NewsMainDependency>, NewsMainBuildable {

    override init(dependency: NewsMainDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: NewsMainListener) -> NewsMainRouting {
        let component = NewsMainComponent(dependency: dependency)
        let viewController = NewsMainViewController()
        let interactor = NewsMainInteractor(presenter: viewController)
        interactor.listener = listener
        return NewsMainRouter(interactor: interactor, viewController: viewController)
    }
}
