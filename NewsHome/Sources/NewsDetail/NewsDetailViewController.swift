/**
 @class NewsDetailViewController
 @date 4/21/24
 @writer kimsoomin
 @brief
 @update history
 -
 */
import ModernRIBs
import UIKit

protocol NewsDetailPresentableListener: AnyObject {
    
}

final class NewsDetailViewController: UIViewController, NewsDetailPresentable, NewsDetailViewControllable {

    weak var listener: NewsDetailPresentableListener?
}
