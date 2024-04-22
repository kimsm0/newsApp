/**
 @class CustomAlert
 @date 4/21/24
 @writer kimsoomin
 @brief
 @update history
 -
 */
import UIKit
import Then
import SnapKit
import Extensions
import Combine

public class CustomAlert: UIViewController {
    
    private let alertView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
    }
    
    private let titleLabel = UILabel().then{
        $0.font = .semibold16
        $0.textColor = .black
    }
    
    private let messageLabel = UILabel().then{
        $0.font = .regular12
        $0.textColor = .black
        $0.textAlignment = .center
    }
    
    private let buttonStackView = UIStackView().then{
        $0.axis = .horizontal
    }
    
    private let cancelButton = UIButton().then{
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(.red, for: .normal)
    }
    
    private let confirmButton = UIButton().then{
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
    }
    var cancelActionClosure: (() -> Void)?
    var confirmActionClosure: (() -> Void)?
    
    var alertTitle: String?
    let alertMessage: String
    let hasCancelButton: Bool
    
    private var subscriptions: Set<AnyCancellable>
    
    init(alertTitle: String? = nil,
         alertMessage: String,
         hasCancelButton: Bool,
         cancelActionClosure: (()-> Void)?,
         confirmActionClosure: (()-> Void)?
    ) {
        self.subscriptions = .init()
        self.alertTitle = alertTitle
        self.alertMessage = alertMessage
        self.hasCancelButton = hasCancelButton
        self.cancelActionClosure = cancelActionClosure
        self.confirmActionClosure = confirmActionClosure
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {        
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        bind()
        setData()
    }
    
    func attribute(){
        self.view.backgroundColor = .black.withAlphaComponent(0.3)
    }
        
    func layout() {
        buttonStackView.addArrangedSubview(cancelButton)
        buttonStackView.addArrangedSubview(confirmButton)
        
        alertView.addSubview(titleLabel)
        alertView.addSubview(messageLabel)
        alertView.addSubview(buttonStackView)
        
        view.addSubview(alertView)
        
        alertView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(230)
        }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(20)
        }
        
        messageLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalToSuperview().offset(20)
            $0.height.equalTo(20)
        }
        
        buttonStackView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(-20)
            $0.trailing.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().offset(-20)
            $0.height.equalTo(45)
            $0.width.equalTo(80)
        }
        
        cancelButton.snp.makeConstraints{
            $0.width.equalTo(40)
            $0.leading.top.bottom.equalToSuperview()
        }
        
        confirmButton.snp.makeConstraints{
            $0.width.equalTo(40)
            $0.trailing.top.bottom.equalToSuperview()
        }
    }
    
    func bind(){
        cancelButton.throttleTapPublisher()
            .sink {[weak self] _ in
                self?.cancelActionClosure?()
            }.store(in: &subscriptions)
        
        confirmButton.throttleTapPublisher()
            .sink {[weak self] _ in
                self?.confirmActionClosure?()
            }.store(in: &subscriptions)
    }
    
    func setData(){
        titleLabel.text = alertTitle
        messageLabel.text = alertMessage
        cancelButton.isHidden = !hasCancelButton
    }
}

extension CustomAlert {
    public class func showAlert(rootVC: UIViewController,
                    alertTitle: String? = nil,
                    alertMessage: String,
                    hasCancelButton: Bool,
                    cancelActionClosure: (()-> Void)?,
                    confirmActionClosure: (()->Void)?
    ) {
        let alert = CustomAlert(alertTitle: alertTitle,
                                alertMessage: alertMessage,
                                hasCancelButton: hasCancelButton,
                                cancelActionClosure:cancelActionClosure,
                                confirmActionClosure: confirmActionClosure)
        
        alert.modalPresentationStyle = .overFullScreen
        alert.modalTransitionStyle = .crossDissolve
        alert.cancelActionClosure = cancelActionClosure
        alert.confirmActionClosure = confirmActionClosure
        rootVC.present(alert, animated: true, completion: nil)
    }
}
