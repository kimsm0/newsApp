/**
 @class NewsDetailRouter
 @date 4/21/24
 @writer kimsoomin
 @brief
 @update history
 -
 */
import ModernRIBs

protocol NewsDetailInteractable: Interactable {
    var router: NewsDetailRouting? { get set }
    var listener: NewsDetailListener? { get set }
}

protocol NewsDetailViewControllable: ViewControllable {
}

final class NewsDetailRouter: ViewableRouter<NewsDetailInteractable, NewsDetailViewControllable>, NewsDetailRouting {

    override init(interactor: NewsDetailInteractable, viewController: NewsDetailViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

extension NewsDetailRouter {    
}
