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
    private let contentImageView = UIImageView().then{
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    private let publisherLable = UILabel().then{
        $0.font = .regular12
        $0.numberOfLines = 0
    }
    private let titleLabel = UILabel().then{
        $0.font = .regular18
        $0.numberOfLines = 0
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
        self.selectionStyle = .none
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func layout(){
        stackView.addArrangedSubview(publisherLable)
        stackView.addArrangedSubview(titleLabel)
        dateWriterView.addSubview(dateLabel)
        dateWriterView.addSubview(authorLabel)
        
        self.addSubview(stackView)
        self.addSubview(lineView)
        self.addSubview(dateWriterView)
        self.addSubview(contentImageView)
        
        stackView.snp.makeConstraints{
            $0.leading.top.equalToSuperview()
            $0.bottom.equalTo(dateWriterView.snp.top).offset(-6)
            $0.trailing.equalTo(contentImageView.snp.leading).offset(-16)
        }
        
        publisherLable.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
        }
        
        contentImageView.snp.makeConstraints{
            $0.trailing.equalToSuperview()
            $0.width.equalTo(120)
            $0.height.equalTo(90)
            $0.centerY.equalTo(stackView.snp.centerY)
        }
        
        dateWriterView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()            
            $0.height.equalTo(30)
            $0.bottom.equalToSuperview()
        }
        
        lineView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        dateLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
        }
        
        authorLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(dateLabel.snp.trailing).offset(-16)
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
