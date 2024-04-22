/**
 @class
 @date 4/21/24
 @writer kimsoomin
 @brief
 - Interactor를 UIKit으로부터 완전 분리하기 위한 Adaptor클래스
 - Modal ViewController를 유저가 drag하여 dismiss하는 액션을 catch한다.
 @update history
 -
 */

import UIKit

public protocol AdaptivePresentationControllerDelegate: AnyObject {
    func presentationControllerDidDismiss()
}
 
public final class AdaptivePresentationControllerDelegateProxy: NSObject, UIAdaptivePresentationControllerDelegate {
    
    public weak var delegate: AdaptivePresentationControllerDelegate?
    
    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        delegate?.presentationControllerDidDismiss()
    }
}
