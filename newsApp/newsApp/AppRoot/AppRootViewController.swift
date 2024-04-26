/**
 @class
 @date
 @writer kimsoomin
 @brief
 @update history
 -
 */

import ModernRIBs
import UIKit
import Extensions

protocol AppRootPresentableListener: AnyObject {
  
}

final class AppRootController: UINavigationController, AppRootViewControllable, AppRootPresentable {
    weak var listener: AppRootPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setViewController(_ viewController: ViewControllable) {   
        
        self.setViewControllers([viewController.uiviewController], animated: true)
    }
}
