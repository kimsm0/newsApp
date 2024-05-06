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

final class NewsMainTopNewsCell: UITableViewCell {
    
    private let stackView = UIStackView().then{
        $0.axis = .vertical
    }
    private let containerView = UIView()
    private lazy var contentImageView = UIImageView().then{
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        $0.accessibilityIdentifier = "newsmain_top_image"
    }
    private let publisherLable = UILabel().then{
        $0.font = .semibold14
        $0.accessibilityIdentifier = "newsmain_top_publisher"
        $0.numberOfLines = 0
    }
    private let titleLabel = UILabel().then{
        $0.font = .bold17
        $0.numberOfLines = 0
        $0.accessibilityIdentifier = "newsmain_top_title"
    }
    private let lineView = UIView().then{
        $0.backgroundColor = .gray
    }
    private let dateAuthorView = UIView()
    
    private let dateLabel = UILabel().then{
        $0.font = .regular12
        $0.accessibilityIdentifier = "newsmain_top_date"
        $0.numberOfLines = 1
    }
    private let authorLabel = UILabel().then{
        $0.font = .regular12
        $0.accessibilityIdentifier = "newsmain_top_author"
        $0.numberOfLines = 1
        $0.lineBreakMode = .byTruncatingTail
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
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
        contentImageView.image = nil
        publisherLable.text = nil
        titleLabel.text = nil
        dateLabel.text = nil
        authorLabel.text = nil
    }
    
    func attribute(){
        self.accessibilityIdentifier = "newsmain_top_cell"
        stackView.layer.borderColor = UIColor.defaultFont.cgColor
        stackView.layer.borderWidth = 2
    }
    func layout(){
        
        containerView.addSubview(contentImageView)
        stackView.addArrangedSubview(containerView)
        stackView.setCustomSpacing(6, after: contentImageView)
        stackView.addArrangedSubview(publisherLable)
        stackView.setCustomSpacing(6, after: publisherLable)
        stackView.addArrangedSubview(titleLabel)
        stackView.setCustomSpacing(6, after: titleLabel)
        stackView.addArrangedSubview(lineView)
        stackView.setCustomSpacing(12, after: lineView)
        stackView.addArrangedSubview(dateAuthorView)
        
        dateAuthorView.addSubview(dateLabel)
        dateAuthorView.addSubview(authorLabel)
        
        self.contentView.addSubview(stackView)
        stackView.snp.makeConstraints{
            $0.leading.top.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-16)
        }
        
        let deviceWidth = CGFloat(UIScreen.main.bounds.width)
        
        containerView.snp.makeConstraints{
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(deviceWidth*2/3)
        }
        
        contentImageView.snp.makeConstraints{
            $0.top.leading.equalToSuperview().offset(6)
            $0.trailing.equalToSuperview().offset(-6)
            $0.bottom.equalToSuperview()
        }
        
        publisherLable.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(6)
            $0.trailing.equalToSuperview().offset(-6)
        }
        
        titleLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(6)
            $0.trailing.equalToSuperview().offset(-6)
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
            $0.width.equalTo(130)
        }
        
        authorLabel.snp.makeConstraints{
            $0.centerY.equalTo(dateLabel.snp.centerY)
            $0.leading.equalTo(dateLabel.snp.trailing).offset(16)
            $0.trailing.equalToSuperview()
        }        
    }
    
    func config(article: ArticleEntity){
        publisherLable.text = article.source.name
        titleLabel.text = article.title
        dateLabel.text = article.publishedAt.changeFormat(formatType: .total(date: .hyphen, time: .full))
        authorLabel.text = article.author
        contentImageView.kf.setImage(with: URL(string: article.urlToImage))        
        titleLabel.sizeToFit()
    }
}
