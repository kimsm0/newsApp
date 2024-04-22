/**
 @class UIViewController+Ex.swift
 @date 4/21/24
 @writer kimsoomin
 @brief
 @update history
 -
 */
import UIKit

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
    func setupNavigationItem(with buttonType: DismissButtonType,
                             target: Any?,
                             action: Selector?
    ) {
        
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      image: UIImage(
        systemName: buttonType.iconSystemName,
        withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold)
      ),
      style: .plain,
      target: target,
      action: action
    )
  }
}
