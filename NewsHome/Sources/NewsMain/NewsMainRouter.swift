/**
 @class NewsMainRouter
 @date 4/21/24
 @writer kimsoomin
 @brief
 @update history
 -
 */
import ModernRIBs
import NewsDetail
import NewsDataModel
import Extensions

protocol NewsMainInteractable: Interactable, NewsDetailListener{
    var router: NewsMainRouting? { get set }
    var listener: NewsMainListener? { get set }
}

protocol NewsMainViewControllable: ViewControllable {
}


final class NewsMainRouter: ViewableRouter<NewsMainInteractable, NewsMainViewControllable>, NewsMainRouting {

    private let newsDetailBuildable: NewsDetailBuildable
    private var newsDetailRouting: Routing?
    
    init(interactor: NewsMainInteractable,
         viewController: NewsMainViewControllable,
         newsDetailBuildable: NewsDetailBuildable
    ) {
        self.newsDetailBuildable = newsDetailBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

extension NewsMainRouter {
    func attachNewsDetail(selectedIndex: Int) {        
        if newsDetailRouting == nil {
            let router = newsDetailBuildable.build(withListener: interactor, startArticleIndex: selectedIndex)
            self.newsDetailRouting = router
            self.viewController.uiviewController.navigationController?.pushViewController(router.viewControllable.uiviewController, animated: true)
            attachChild(router)
        }
    }
    
    func detachNewsDetail() {
        if let router = newsDetailRouting {
            self.viewController.uiviewController.navigationController?.popViewController(animated: true)
            detachChild(router)
            newsDetailRouting = nil
        }
    }
}
