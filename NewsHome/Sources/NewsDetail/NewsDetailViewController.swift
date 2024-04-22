/**
 @class NewsDetailViewController
 @date 4/21/24
 @writer kimsoomin
 @brief
 @update history
 -
 */
import ModernRIBs
import UIKit
import SnapKit
import Then
import Kingfisher
import Extensions
import CustomUI
import NewsDataModel


protocol NewsDetailPresentableListener: AnyObject {
    
}

final class NewsDetailViewController: UIViewController, NewsDetailPresentable, NewsDetailViewControllable {

    weak var listener: NewsDetailPresentableListener?
    
    private let scrollView = UIScrollView()
    
    private let stackView = UIStackView().then{
        $0.axis = .vertical
    }
    private let titleLabel = UILabel().then{
        $0.font = .bold25
        $0.numberOfLines = 0
    }
    private let subTitleLabel = UILabel().then{
        $0.font = .regular18
        $0.numberOfLines = 0
    }
        
    private let authorLabel = UILabel().then{
        $0.font = .semibold14
        $0.numberOfLines = 1
    }
    private let dateLabel = UILabel().then{
        $0.font = .regular12
        $0.numberOfLines = 1
    }
    private let contentLabel = UILabel().then{
        $0.font = .regular12
        $0.numberOfLines = 0
    }
    
    private let contentImageView = UIImageView()
    private let lineView = UIView().then{
        $0.backgroundColor = .lightGray
    }
    
    private let moveButtonView = MoveButtonView()
    
    private let news: ArticleEntity
    
    init(_ news: ArticleEntity){
        self.news = news
        super.init(nibName: nil, bundle: nil)
        layout()
    }
    
    required init?(coder: NSCoder) {
        self.news = .init(source: .init(id: "", name: ""), author: "", title: "", description: "", url: "", urlToImage: "", publishedAt: "", content: "")
        super.init(coder: coder)
        layout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationItem(left: .dismiss(.back),
                                 title: news.source.name,
                                 target: self,
                                 action: #selector(didTapBackButton)
        )
    }
    
    func layout(){
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subTitleLabel)
        stackView.addArrangedSubview(contentImageView)
        stackView.addArrangedSubview(authorLabel)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(contentLabel)
        
        scrollView.addSubview(stackView)
        self.view.addSubview(scrollView)
        self.view.addSubview(moveButtonView)
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalTo(moveButtonView.snp.top)
        }
        
        moveButtonView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(70)
        }
        
        stackView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
        }
        subTitleLabel.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
        }
        contentImageView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
        }
        authorLabel.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
        }
        dateLabel.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
        }
        lineView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        contentLabel.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    func update() {        
        titleLabel.text = news.title
        subTitleLabel.text = news.description
        dateLabel.text = news.publishedAt
        authorLabel.text = news.author
        contentLabel.text = news.content
        contentImageView.kf.setImage(with: URL(string: news.urlToImage))
    }
    
    @objc
    private func didTapBackButton() {
      //listener?.didTapClose()
    }
}
