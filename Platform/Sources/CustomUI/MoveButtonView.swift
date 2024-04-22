/**
 @class
 @date 4/22/24
 @writer kimsoomin
 @brief
 @update history
 -
 */
import UIKit
import SnapKit
import Then

public final class MoveButtonView: UIView {
    
    private let lineView = UIView().then{
        $0.backgroundColor = .lightGray
    }
    
    public lazy var preButton = UIButton().then {
        $0.setImage(UIImage(systemName: "arrow.backward",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize:18, weight: .semibold)),
                    for: .normal)
        $0.tintColor = .black
    }
    
    public lazy var nextButton = UIButton().then {
        $0.setImage(UIImage(systemName: "arrow.right",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize:18, weight: .semibold)),
                    for: .normal)
        $0.tintColor = .black
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layout()
    }
    
    func layout(){
        self.addSubview(lineView)
        self.addSubview(preButton)
        self.addSubview(nextButton)
        
        lineView.snp.makeConstraints{
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        preButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.height.width.equalTo(30)
            $0.centerY.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints {
            $0.leading.equalTo(preButton.snp.trailing).offset(40)
            $0.height.width.equalTo(30)
            $0.centerY.equalToSuperview()
        }
    }
}

