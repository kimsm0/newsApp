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
    private lazy var contentImageView = UIImageView().then{
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        $0.accessibilityIdentifier = "newsmain_top_image"
    }
    private let publisherLable = UILabel().then{
        $0.font = .semibold14
        $0.accessibilityIdentifier = "newsmain_top_publisher"
    }
    private let titleLabel = UILabel().then{
        $0.font = .bold17
        $0.numberOfLines = 3
        $0.accessibilityIdentifier = "newsmain_top_title"
    }
    private let lineView = UIView().then{
        $0.backgroundColor = .gray
    }
    private let dateAuthorView = UIView()
    
    private let dateLabel = UILabel().then{
        $0.font = .regular12
        $0.accessibilityIdentifier = "newsmain_top_date"
    }
    private let authorLabel = UILabel().then{
        $0.font = .regular12
        $0.accessibilityIdentifier = "newsmain_top_author"
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
        contentView.frame = contentView.frame.inset(by: .init(top: 0, left: 0, bottom: 12, right: 0))
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
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 2
    }
    func layout(){
        
        stackView.addArrangedSubview(contentImageView)
        stackView.addArrangedSubview(publisherLable)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(lineView)
        stackView.addArrangedSubview(dateAuthorView)
        
        dateAuthorView.addSubview(dateLabel)
        dateAuthorView.addSubview(authorLabel)
        
        stackView.setCustomSpacing(6, after: contentImageView)
        stackView.setCustomSpacing(6, after: publisherLable)
        stackView.setCustomSpacing(6, after: titleLabel)
        stackView.setCustomSpacing(6, after: lineView)
        stackView.setCustomSpacing(6, after: dateAuthorView)
        
        self.contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints{
            $0.leading.top.equalToSuperview().offset(6)
            $0.trailing.bottom.equalToSuperview().offset(-6)
        }
        
        contentImageView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(10)
        }
        
        publisherLable.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
        }
        
        lineView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        dateAuthorView.snp.makeConstraints{
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(30)
        }
                        
        dateLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
        }
        
        authorLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(dateLabel.snp.trailing).offset(16)
        }
    }
    
    func config(article: ArticleEntity){
        publisherLable.text = article.source.name
        titleLabel.text = article.title
        dateLabel.text = article.publishedAt
        authorLabel.text = article.author
        
        contentImageView.kf.setImage(with: URL(string: article.urlToImage)) {[weak self] result in
            guard let weakSelf = self else { return }
            
            switch result {
            case .success(let value):
                let deviceWidth = CGFloat(UIScreen.main.bounds.width)                
                let newHeight = (deviceWidth * value.image.size.height) / value.image.size.width
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                    weakSelf.contentImageView.snp.remakeConstraints {
                        $0.height.equalTo(newHeight)
                        $0.leading.trailing.equalToSuperview()
                    }
                    weakSelf.stackView.needsUpdateConstraints()
                    weakSelf.stackView.setNeedsLayout()
                })
                break
            default:
                break
            }
        }
    }
}
