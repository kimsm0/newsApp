/**
 @class UIViewController+Ex.swift
 @date 4/21/24
 @writer kimsoomin
 @brief
 @update history
 -
 */
import UIKit

public enum LeftNaviItem {
    case dismiss(DismissButtonType)
    case text(String)
}

public enum DismissButtonType {
  case back, close
  
  public var iconSystemName: String {
    switch self {
    case .back:
      return "chevron.backward"
    case .close:
      return "xmark"
    }
  }
}

public extension UIViewController {
    func setupNavigationItem(left: LeftNaviItem,
                             title: String?,
                             target: AnyObject?,
                             action: Selector?
    ) {
        self.navigationItem.title = title
        
        let leftItem = UIBarButtonItem()
                
        switch left {
        case .dismiss(let type):
            leftItem.image = UIImage(
                systemName: type.iconSystemName,
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, 
                                                               weight: .semibold)
            )
        case .text(let name):
            let label = UILabel()
            label.text = name
            label.font = .bold25
            label.textColor = .defaultFont
            leftItem.customView = label
            
        }
        leftItem.style = .plain
        leftItem.tintColor = .defaultFont
        leftItem.target = target
        leftItem.action = action
        navigationItem.leftBarButtonItem = leftItem
        if #available(iOS 14.0, *) {
            navigationItem.backButtonDisplayMode = .minimal
        } else {
            // Fallback on earlier versions
        }
        leftItem.accessibilityIdentifier = "navigation_left_item"
        navigationItem.titleView?.accessibilityIdentifier = "navigation_title"
        
        self.navigationController?.navigationBar.shadowImage = UIImage()        
    }
    
    func setNavigationTitle(title: String) {
        self.navigationItem.title = title
    }
    
    var topViewController: UIViewController {
        var top: UIViewController = self
        while let presented = top.presentedViewController {
            top = presented
        }
        return top
    }
}
