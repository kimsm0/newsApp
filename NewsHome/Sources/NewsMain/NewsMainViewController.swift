/**
 @class NewsMainViewController
 @date 4/21/24
 @writer kimsoomin
 @brief
 @update history
 -
 */
import ModernRIBs
import UIKit

protocol NewsMainPresentableListener: AnyObject {
   
}

final class NewsMainViewController: UIViewController, NewsMainPresentable, NewsMainViewControllable {

    weak var listener: NewsMainPresentableListener?
}
