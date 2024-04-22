/**
 @class NewsDetailBuilder
 @date 4/21/24
 @writer kimsoomin
 @brief
 @update history
 -
 */
import ModernRIBs

protocol NewsDetailDependency: Dependency {
   
}

final class NewsDetailComponent: Component<NewsDetailDependency> {

}

// MARK: - Builder

protocol NewsDetailBuildable: Buildable {
    func build(withListener listener: NewsDetailListener) -> NewsDetailRouting
}

final class NewsDetailBuilder: Builder<NewsDetailDependency>, NewsDetailBuildable {

    override init(dependency: NewsDetailDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: NewsDetailListener) -> NewsDetailRouting {
        let component = NewsDetailComponent(dependency: dependency)
        let viewController = NewsDetailViewController()
        let interactor = NewsDetailInteractor(presenter: viewController)
        interactor.listener = listener
        return NewsDetailRouter(interactor: interactor, viewController: viewController)
    }
}
