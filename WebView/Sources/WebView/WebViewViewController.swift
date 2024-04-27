/**
 @class WebViewViewController
 @date 4/27/24
 @writer kimsoomin
 @brief
 @update history
 -
 */
import UIKit
import WebKit
import ModernRIBs
import Then
import SnapKit
import Extensions
import Common

protocol WebViewPresentableListener: AnyObject {
    func detachWebView()
}

class commonProcessPool {
    static let instance = commonProcessPool()
    let processPool = WKProcessPool()
    func getProcessPool() -> WKProcessPool{
        return processPool
    }
}

final class WebViewController: UIViewController, WebViewPresentable, WebViewViewControllable {

    weak var listener: WebViewPresentableListener?
    
    private let progressView = UIProgressView(progressViewStyle: .default).then{
        $0.tintColor = .black
    }
    private var estimatedProgressObserver: NSKeyValueObservation?
    
    var wkWebView:WKWebView? = nil
    var urlRequest:URLRequest?
    
    init(urlString: String) {
        if let url = URL(string: urlString){
            self.urlRequest = URLRequest(url: url)
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: view life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        
        let config = WKWebViewConfiguration()
        
        let userContentController = WKUserContentController()
        
        config.userContentController = userContentController
        config.processPool = commonProcessPool.instance.getProcessPool()
        wkWebView = WKWebView(frame: .zero, configuration: config)
        #if AppStore
        
        #else
        if #available(iOS 16.4, *) {
            wkWebView?.isInspectable = true
        } else {
            // Fallback on earlier versions
        }
        #endif
        wkWebView?.scrollView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
                
        self.setupNavigationItem(left: .dismiss(.back),
                                 title: nil,
                                 target: self,
                                 action: #selector(didTapBackButton)
        )
        self.attribute()
        self.layout()
        self.setupProgressView()
        self.setupEstimatedProgressObserver()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @inlinable
    func attribute(){
        self.view.backgroundColor = .white
        guard let webView = wkWebView else { return }
        guard let request = urlRequest else { return }
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.allowsLinkPreview = false
        webView.load(request)
        
    }
    
    @inlinable
    func layout(){
        guard let webView = wkWebView else { return }
        view.addSubview(webView)
//        let top = (self.navigationController?.navigationBar.frame.height ?? 0) + (self.navigationController?.navigationBar.frame.origin.y ?? 0)
        webView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    @objc
    private func didTapBackButton() {
        listener?.detachWebView()
    }
}


extension WebViewController: WKNavigationDelegate{
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView,
                 didFinish navigation: WKNavigation!) {
        
        UIView.animate(withDuration: 0.33,
                               animations: {
                                   self.progressView.alpha = 0.0
                               },
                       completion: { isFinished in
            self.progressView.isHidden = isFinished
        })
    }
    
    func webView(_ webView: WKWebView,
                 didStartProvisionalNavigation navigation: WKNavigation!) {
        if progressView.isHidden {
            progressView.isHidden = false
        }
                
        UIView.animate(withDuration: 0.33,
                               animations: {
            self.progressView.alpha = 1.0
        })
    }
    
    func webView(_ webView: WKWebView,
                 didFail navigation: WKNavigation!,
                 withError error: Error) {
        printLog(error.localizedDescription)
    }
    
    func webView(_ webView: WKWebView,
                 didFailProvisionalNavigation navigation: WKNavigation!,
                 withError error: Error) {
        printLog(error.localizedDescription)
    }
    
    func webView(_ webView: WKWebView,
                 runJavaScriptConfirmPanelWithMessage message: String,
                 initiatedByFrame frame: WKFrameInfo,
                 completionHandler: @escaping (Bool) -> Void) {
        
        let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert);
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) {
            _ in completionHandler(false)
        }
        let okAction = UIAlertAction(title: "확인", style: .default) {
            _ in completionHandler(true)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func webView(_ webView: WKWebView,
                 runJavaScriptAlertPanelWithMessage message: String,
                 initiatedByFrame frame: WKFrameInfo,
                 completionHandler: @escaping () -> Swift.Void) {

        let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert);

        let cancelAction = UIAlertAction(title: "확인", style: .cancel) {
            _ in completionHandler()
        }

        alertController.addAction(cancelAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }

    func webViewWebContentProcessDidTerminate(_ webView: WKWebView){
        printLog(nil)
    }
}
extension WebViewController: WKUIDelegate { }


extension WebViewController {
    private func setupProgressView() {
        guard let navigationBar = navigationController?.navigationBar else {
            printLog("NavigationBar nil")
            return
        }
        progressView.isHidden = true

        progressView.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.addSubview(progressView)

        progressView.snp.makeConstraints{
            $0.leading.equalTo(navigationBar.snp.leading)
            $0.trailing.equalTo(navigationBar.snp.trailing)
            $0.bottom.equalTo(navigationBar.snp.bottom)
            $0.height.equalTo(2)
        }
    }

    private func setupEstimatedProgressObserver() {
        estimatedProgressObserver = wkWebView?.observe(\.estimatedProgress,
                                                        options: [.new]) { [weak self] webView, _ in
            guard let weakSelf = self else { return }
            weakSelf.progressView.progress = Float(webView.estimatedProgress)
        }
    }
}
