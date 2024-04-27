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
        
    private let publisherLable = UILabel().then{
        $0.font = .semibold14
        $0.accessibilityIdentifier = "newsmain_publisher"
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
    private let dateWriterView = UIView()
    
    private let dateLabel = UILabel().then{
        $0.font = .regular12
        $0.accessibilityIdentifier = "newsmain_date"
    }
    
    private let authorLabel = UILabel().then{
        $0.font = .regular12
        $0.accessibilityIdentifier = "newsmain_author"
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
        contentView.frame = contentView.frame.inset(by: .init(top: 0, left: 0, bottom: 12, right: 0))
    }
    
    private var test = UIView()
    
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
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 2
    }
    
    func layout(){
        imageContainerView.addSubview(contentImageView)
        
        dateWriterView.addSubview(dateLabel)
        dateWriterView.addSubview(authorLabel)
        
        test.addSubview(titleLabel)
        
        contentStackView.addArrangedSubview(test)
        contentStackView.setCustomSpacing(6, after: test)
        contentStackView.addArrangedSubview(imageContainerView)
        
        stackView.addArrangedSubview(publisherLable)
        stackView.addArrangedSubview(contentStackView)
        stackView.setCustomSpacing(6, after: contentStackView)
        stackView.addArrangedSubview(lineView)
        stackView.addArrangedSubview(dateWriterView)
                        
        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints{
            $0.leading.top.equalToSuperview().offset(6)
            $0.trailing.bottom.equalToSuperview().offset(-6)
        }
        
        let deviceWidth = CGFloat(UIScreen.main.bounds.width)
        contentStackView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.height.greaterThanOrEqualTo((deviceWidth*0.33) * 3/4)
        }
        publisherLable.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        test.backgroundColor = .green
        titleLabel.backgroundColor = .yellow
        contentStackView.backgroundColor = .gray
        
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
            $0.leading.trailing.equalToSuperview()
        }
             
        imageContainerView.backgroundColor = .red
        imageContainerView.snp.makeConstraints{
            $0.width.equalTo(deviceWidth*0.33)
            $0.top.bottom.trailing.equalToSuperview()
        }
        contentImageView.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.width.equalTo(deviceWidth*0.33)
            $0.height.equalTo((deviceWidth*0.33) * 3/4)
            
        }
        
        lineView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        dateWriterView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
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
    
        publisherLable.text = article.source.name ?? "신문사"
        titleLabel.text = article.title
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
