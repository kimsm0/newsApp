
/**
 @class WebViewInteractor
 @date 4/27/24
 @writer kimsoomin
 @brief
 @update history
 -
 */
import ModernRIBs

protocol WebViewRouting: ViewableRouting {
}

protocol WebViewPresentable: Presentable {
    var listener: WebViewPresentableListener? { get set }
}

public protocol WebViewListener: AnyObject {
    func detachWebView()
}

final class WebViewInteractor: PresentableInteractor<WebViewPresentable>, WebViewInteractable, WebViewPresentableListener {
    
    weak var router: WebViewRouting?
    weak var listener: WebViewListener?

    
    override init(presenter: WebViewPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()
    }
}

extension WebViewInteractor {
    func detachWebView() {
        listener?.detachWebView()
    }
}
