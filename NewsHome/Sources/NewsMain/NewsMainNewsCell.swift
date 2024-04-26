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
    
    private let containerView = UIView()
    
    private let stackView = UIStackView().then{
        $0.axis = .vertical
    }
    private let contentImageView = UIImageView().then{
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 6
    }
    private let publisherLable = UILabel().then{
        $0.font = .semibold14
    }
    private let titleLabel = UILabel().then{
        $0.font = .semibold16
        $0.numberOfLines = 3
    }
    
    private let dateWriterView = UIView()
    private let lineView = UIView().then{
        $0.backgroundColor = .lightGray
    }
    
    private let dateLabel = UILabel().then{
        $0.font = .regular12
    }
    
    private let authorLabel = UILabel().then{
        $0.font = .regular12
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        publisherLable.text = nil
        titleLabel.text = nil
        dateLabel.text = nil
        authorLabel.text = nil
        contentImageView.image = nil
    }
    
    func attribute(){
        self.selectionStyle = .none
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 2
    }
    
    func layout(){
        stackView.addArrangedSubview(publisherLable)
        stackView.addArrangedSubview(titleLabel)
        dateWriterView.addSubview(dateLabel)
        dateWriterView.addSubview(authorLabel)
        
        containerView.addSubview(stackView)
        containerView.addSubview(contentImageView)
        
        contentView.addSubview(containerView)
        contentView.addSubview(lineView)
        contentView.addSubview(dateWriterView)
        
        
        containerView.snp.makeConstraints{
            $0.leading.top.equalToSuperview().offset(6)
            $0.trailing.equalToSuperview().offset(-6)
            $0.bottom.equalTo(lineView.snp.top).offset(-6)
        }
        
        
        contentImageView.snp.makeConstraints{
            $0.width.equalTo(120)
            $0.height.equalTo(90)
            $0.top.equalToSuperview().offset(6)
            $0.trailing.equalToSuperview().offset(-6)
            $0.bottom.equalToSuperview().offset(-6)
            $0.leading.equalTo(stackView.snp.trailing).offset(6)
        }
        
        
        stackView.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        publisherLable.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
        }
        
        dateWriterView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(6)
            $0.trailing.bottom.equalToSuperview().offset(-6)
            $0.height.equalTo(30)
        }
        
        lineView.snp.makeConstraints{
            $0.bottom.equalTo(dateWriterView.snp.top).offset(-6)
            $0.leading.equalToSuperview().offset(6)
            $0.trailing.equalToSuperview().offset(-6)
            $0.height.equalTo(1)
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
        
        contentImageView.kf.setImage(with: URL(string: article.urlToImage))
    }
}
