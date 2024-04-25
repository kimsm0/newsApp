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

final class NewsTitleHeaderView: UITableViewHeaderFooterView {
    private let titleLabel = UILabel().then{
        $0.text = "Top Stories"
        $0.font = .semibold16
        $0.accessibilityIdentifier = "NewsTitleHeaderView"
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func layout(){
        self.addSubview(titleLabel)
       
        titleLabel.snp.makeConstraints{
            $0.leading.centerY.equalToSuperview()
            $0.height.equalTo(25)            
        }
    }
}


