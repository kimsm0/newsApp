/**
 @class
 @date 4/22/24
 @writer kimsoomin
 @brief
 @update history
 -
 */
import UIKit
import Kingfisher
import SnapKit
import Then
import Extensions
import NewsDataModel

final class NewsMainNewsCell: UITableViewCell {
    
    private let stackView = UIStackView().then{
        $0.axis = .vertical
    }
        
    private let containerView = UIView()
    private let publisherLable = UILabel().then{
        $0.font = .semibold14
        $0.accessibilityIdentifier = "newsmain_publisher"
        $0.numberOfLines = 1
        $0.lineBreakMode = .byTruncatingTail
    }
        
    private let contentStackView = UIStackView().then{
        $0.axis = .horizontal
    }

    private let titleLabel = UILabel().then{
        $0.font = .semibold16
        $0.numberOfLines = 0
        $0.accessibilityIdentifier = "newsmain_title"
    }
    private let imageContainerView = UIView()
        
    private let contentImageView = UIImageView().then{
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 6
        $0.accessibilityIdentifier = "newsmain_image"
    }
    
    private let lineView = UIView().then{
        $0.backgroundColor = .lightGray
    }
    private let dateAuthorView = UIView()
    
    private let dateLabel = UILabel().then{
        $0.font = .regular12
        $0.accessibilityIdentifier = "newsmain_date"
        $0.numberOfLines = 1
    }
    
    private let authorLabel = UILabel().then{
        $0.font = .regular12
        $0.accessibilityIdentifier = "newsmain_author"
        $0.numberOfLines = 1
        $0.lineBreakMode = .byTruncatingTail
    }
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        publisherLable.text = nil
        titleLabel.text = nil
        dateLabel.text = nil
        authorLabel.text = nil
        contentImageView.image = nil
    }
    
    func attribute(){
        self.accessibilityIdentifier = "newsmain_cell"
        self.selectionStyle = .none
        stackView.layer.borderColor = UIColor.black.cgColor
        stackView.layer.borderWidth = 2
    }
    
    func layout(){
        containerView.addSubview(publisherLable)
        imageContainerView.addSubview(contentImageView)
        
        dateAuthorView.addSubview(dateLabel)
        dateAuthorView.addSubview(authorLabel)
                
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.setCustomSpacing(6, after: titleLabel)
        contentStackView.addArrangedSubview(imageContainerView)
        
        stackView.addArrangedSubview(containerView)
        stackView.setCustomSpacing(6, after: publisherLable)
        stackView.addArrangedSubview(contentStackView)
        stackView.setCustomSpacing(6, after: contentStackView)
        stackView.addArrangedSubview(lineView)
        stackView.setCustomSpacing(12, after: lineView)
        stackView.addArrangedSubview(dateAuthorView)
                        
        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints{
            $0.leading.top.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-16)
        }
        
        let deviceWidth = CGFloat(UIScreen.main.bounds.width)
        contentStackView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(6)
            $0.trailing.equalToSuperview().offset(-6)
            $0.height.greaterThanOrEqualTo((deviceWidth*0.33) * 3/4)
        }
        containerView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(6)
            $0.trailing.equalToSuperview().offset(-6)
            $0.height.equalTo(26)
        }
        
        publisherLable.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(6)
        }
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
        }
        imageContainerView.snp.makeConstraints{
            $0.width.equalTo(deviceWidth*0.33)
        }
        contentImageView.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.width.equalTo(deviceWidth*0.33)
            $0.height.equalTo((deviceWidth*0.33) * 3/4)
        }
        
        lineView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(6)
            $0.trailing.equalToSuperview().offset(-6)
            $0.height.equalTo(1)
        }
        
        dateAuthorView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(6)
            $0.trailing.equalToSuperview().offset(-6)
            $0.height.equalTo(28)
        }
                        
        dateLabel.snp.makeConstraints{
            $0.top.leading.equalToSuperview()
        }
        
        authorLabel.snp.makeConstraints{
            $0.centerY.equalTo(dateLabel.snp.centerY)
            $0.leading.equalTo(dateLabel.snp.trailing).offset(16)
        }
    }
    
    func config(article: ArticleEntity){
    
        publisherLable.text = article.source.name ?? "신문사"
        titleLabel.text = "Toledo, Ohio — An Ohio man who was handcuffed and left facedown on the floor of a social club last week died in police custody, and the officers involved have been placed on paid administrative leave… [+4680 chars]"
        dateLabel.text = article.publishedAt
        authorLabel.text = article.author
        
        if article.urlToImage.isEmpty {
            contentImageView.isHidden = true
        }else {
            contentImageView.isHidden = false
            contentImageView.kf.setImage(with: URL(string: article.urlToImage))
        }
        titleLabel.sizeToFit()
    }
}
