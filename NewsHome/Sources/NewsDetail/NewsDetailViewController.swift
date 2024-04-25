/**
 @class NewsDetailViewController
 @date 4/21/24
 @writer kimsoomin
 @brief
 @update history
 -
 */
import ModernRIBs
import Combine
import UIKit
import SnapKit
import Then
import Kingfisher
import Extensions
import CustomUI
import NewsDataModel


protocol NewsDetailPresentableListener: AnyObject {
    func didTapBackButton()
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
    
    private var totalArticles: [ArticleEntity]
    private var indexSubject = CurrentValueSubject<Int, Never>(0)
    
    private var subscriptions: Set<AnyCancellable>
    
    init(startArticleIndex: Int, totalArticles: [ArticleEntity]){
        self.subscriptions = .init()
        self.totalArticles = totalArticles        
        super.init(nibName: nil, bundle: nil)
        layout()
        bind()
        self.indexSubject.send(startArticleIndex)
    }
    
    required init?(coder: NSCoder) {            
        fatalError("fatal error")
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        super.viewDidLoad()
    }
    
    func layout(){
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subTitleLabel)
        stackView.addArrangedSubview(contentImageView)
        stackView.addArrangedSubview(authorLabel)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(lineView)
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
    
    func bind(){
        moveButtonView.nextButton.throttleTapPublisher()
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _  in
                if let self {
                    let index = self.indexSubject.value
                    self.indexSubject.send(index + 1)
                }
            }.store(in: &subscriptions)
        
        moveButtonView.preButton.throttleTapPublisher()
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _  in
                if let self {
                    let index = self.indexSubject.value
                    self.indexSubject.send(index - 1)
                }
            }.store(in: &subscriptions)
        
        indexSubject.sink {[weak self] index in
            guard let weakSelf = self else { return }
            
            if let article = weakSelf.totalArticles[safe: index] {
                weakSelf.setupNavigationItem(left: .dismiss(.back),
                                             title: article.source.name,
                                             target: weakSelf,
                                             action: #selector(weakSelf.didTapBackButton)
                )
                
                weakSelf.titleLabel.text = article.title
                weakSelf.subTitleLabel.text = article.description
                weakSelf.dateLabel.text = article.publishedAt
                weakSelf.authorLabel.text = article.author
                weakSelf.contentLabel.text = article.content
                weakSelf.contentImageView.kf.setImage(with: URL(string: article.urlToImage))
            } else {
                weakSelf.setupNavigationItem(left: .dismiss(.back),
                                             title: "",
                                             target: weakSelf,
                                             action: #selector(weakSelf.didTapBackButton)
                )
                weakSelf.titleLabel.text = ""
                weakSelf.subTitleLabel.text = ""
                weakSelf.dateLabel.text = ""
                weakSelf.authorLabel.text = ""
                weakSelf.contentLabel.text = ""
                weakSelf.contentImageView.image = nil
            }
        }.store(in: &subscriptions)
    }
    
    
    @objc
    private func didTapBackButton() {
      listener?.didTapBackButton()
    }
}
