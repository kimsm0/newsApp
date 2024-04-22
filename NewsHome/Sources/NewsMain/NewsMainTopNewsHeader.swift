/**
 @class
 @date 4/22/24
 @writer kimsoomin
 @brief
 @update history
 -
 */
import UIKit
import Extensions

final class SearchTitleHeaderView: UIView {
    private let titleLabel = UILabel().then{
        $0.text = "Top Stories"
        $0.font = .semibold16
        $0.accessibilityIdentifier = "SearchTitleHeaderView"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func layout(){
        self.addSubview(titleLabel)
       
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(38)
            $0.height.equalTo(25)
            $0.leading.equalToSuperview()
        }
    }
}


