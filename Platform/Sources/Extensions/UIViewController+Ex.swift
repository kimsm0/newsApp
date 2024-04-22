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
            label.textColor = .black
            leftItem.customView = label
            
        }
        leftItem.style = .plain
        leftItem.target = target
        leftItem.action = action
        navigationItem.leftBarButtonItem = leftItem
    }
}
