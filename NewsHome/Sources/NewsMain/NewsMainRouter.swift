/**
 @class NewsMainRouter
 @date 4/21/24
 @writer kimsoomin
 @brief
 @update history
 -
 */
import ModernRIBs

protocol NewsMainInteractable: Interactable {
    var router: NewsMainRouting? { get set }
    var listener: NewsMainListener? { get set }
}

protocol NewsMainViewControllable: ViewControllable {
}

final class NewsMainRouter: ViewableRouter<NewsMainInteractable, NewsMainViewControllable>, NewsMainRouting {

    override init(interactor: NewsMainInteractable, viewController: NewsMainViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
