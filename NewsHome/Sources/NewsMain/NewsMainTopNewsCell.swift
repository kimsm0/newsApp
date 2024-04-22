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
    private let contentImageView = UIImageView().then{
        $0.contentMode = .scaleAspectFill
    }
    private let publisherLable = UILabel().then{
        $0.font = .regular12
    }
    private let titleLabel = UILabel().then{
        $0.font = .regular18
    }
    private let lineView = UIView().then{
        $0.backgroundColor = .lightGray
    }
    private let dateAuthorView = UIView()
    
    private let dateLabel = UILabel().then{
        $0.font = .regular12
    }    
    private let authorLabel = UILabel().then{
        $0.font = .regular12
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func layout(){
        
        stackView.addArrangedSubview(contentImageView)
        stackView.addArrangedSubview(publisherLable)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(lineView)
        stackView.addArrangedSubview(dateAuthorView)
        
        dateAuthorView.addSubview(dateLabel)
        dateAuthorView.addSubview(authorLabel)
        
        self.addSubview(stackView)
        
        stackView.snp.makeConstraints{
            $0.leading.top.trailing.equalToSuperview()
        }
        contentImageView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(140)
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
            $0.leading.equalTo(dateLabel.snp.trailing).offset(-16)
        }
    }
    
    func config(news: ArticleEntity){
        publisherLable.text = news.source.name 
        titleLabel.text = news.title
        dateLabel.text = news.publishedAt
        authorLabel.text = news.author        
        contentImageView.kf.setImage(with: URL(string: news.urlToImage))
    }
}
