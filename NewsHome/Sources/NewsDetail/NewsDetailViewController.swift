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
    func didTapBackButton(index: Int)
    func loadMoreFromDetail()
    func didTabReadMoreButton(url: String)
}

final class NewsDetailViewController: UIViewController, NewsDetailPresentable, NewsDetailViewControllable {

    weak var listener: NewsDetailPresentableListener?
    
    private let scrollView = UIScrollView().then{
        $0.showsVerticalScrollIndicator = false 
    }
    
    private let stackView = UIStackView().then{
        $0.axis = .vertical
    }
    private let topLineView = UIView().then{
        $0.backgroundColor = .defaultFont
    }
    private let titleLabel = UILabel().then{
        $0.font = .bold25
        $0.numberOfLines = 0
        $0.accessibilityIdentifier = "newsdetail_title"
    }
    private let subTitleLabel = UILabel().then{
        $0.font = .semibold16
        $0.numberOfLines = 0
        $0.accessibilityIdentifier = "newsdetail_description"
    }
        
    private let authorLabel = UILabel().then{
        $0.font = .semibold14
        $0.numberOfLines = 1
        $0.accessibilityIdentifier = "newsdetail_author"
    }
    private let dateLabel = UILabel().then{
        $0.font = .regular12
        $0.numberOfLines = 1
        $0.accessibilityIdentifier = "newsdetail_date"
    }
    
    private let contentView = UIView()
    private let contentLabel = UILabel().then{
        $0.font = .semibold12
        $0.numberOfLines = 0
        $0.accessibilityIdentifier = "newsdetail_content"
    }
    
    private let readMoreButton = UIButton().then{
        $0.backgroundColor = .clear
        $0.accessibilityIdentifier = "newwdetail_more_button"
    }
    
    private let contentImageView = UIImageView().then{
        $0.accessibilityIdentifier = "newsdetail_image"
    }
    private let lineView = UIView().then{
        $0.backgroundColor = .lightGray
    }
    
    private let moveButtonView = MoveButtonView()
    
    private var totalEntity: ArticleTotalEntity?
    private var indexSubject = CurrentValueSubject<Int?, Never>(nil)
    private var subscriptions: Set<AnyCancellable>
    
    init(){
        self.subscriptions = .init()
        super.init(nibName: nil, bundle: nil)
        layout()
        bind()
    }
    
    required init?(coder: NSCoder) {            
        fatalError("fatal error")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .defaultBg
        setupNavigationItem(left: .dismiss(.back),
                            title: "",
                            target: self,
                            action: #selector(self.didTapBackButton)
        )
    }
    
    func layout(){   
        contentView.addSubview(contentLabel)
        contentView.addSubview(readMoreButton)
        
        stackView.setCustomSpacing(6, after: topLineView)
        stackView.addArrangedSubview(titleLabel)
        stackView.setCustomSpacing(12, after: titleLabel)
        stackView.addArrangedSubview(subTitleLabel)
        stackView.setCustomSpacing(12, after: subTitleLabel)
        stackView.addArrangedSubview(contentImageView)
        stackView.setCustomSpacing(12, after: contentImageView)
        stackView.addArrangedSubview(authorLabel)
        stackView.setCustomSpacing(6, after: authorLabel)
        stackView.addArrangedSubview(dateLabel)
        stackView.setCustomSpacing(6, after: dateLabel)
        stackView.addArrangedSubview(lineView)
        stackView.setCustomSpacing(25, after: lineView)
        stackView.addArrangedSubview(contentView)
        
        scrollView.addSubview(stackView)
        self.view.addSubview(topLineView)
        self.view.addSubview(scrollView)
        self.view.addSubview(moveButtonView)
                
        topLineView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.height.equalTo(1)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(topLineView.snp.bottom).offset(12)
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
            $0.height.equalTo(10)
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
        contentView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
        }
        contentLabel.snp.makeConstraints{
            $0.leading.top.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-20)
        }
        readMoreButton.snp.makeConstraints{
            $0.leading.top.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
    
    func bind(){
        moveButtonView.nextButton.throttleTapPublisher()
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _  in
                if let self, let index = self.indexSubject.value {
                    if let totalEntity = self.totalEntity, totalEntity.articles.count - 1 == index
                    {
                        listener?.loadMoreFromDetail()
                    }else {
                        self.indexSubject.send(index + 1)
                    }
                }
            }.store(in: &subscriptions)
        
        moveButtonView.preButton.throttleTapPublisher()
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _  in
                if let self, let index = self.indexSubject.value {
                    self.indexSubject.send(index - 1)
                }
            }.store(in: &subscriptions)
        
        indexSubject.sink {[weak self] index in
            guard let weakSelf = self, let index = index else { return }
            weakSelf.moveButtonView.nextButton.isEnabled = (index < (weakSelf.totalEntity?.totalResults ?? 0) - 1)
            weakSelf.moveButtonView.preButton.isEnabled = (index != 0)
            
            if let article = weakSelf.totalEntity?.articles[safe: index]{
                weakSelf.config(article: article)
            } else {
                weakSelf.reset()
            }
        }.store(in: &subscriptions)
        
        
        readMoreButton.throttleTapPublisher()
            .sink {[weak self] _ in
                if let index = self?.indexSubject.value,
                    let curArticle = self?.totalEntity?.articles[safe: index] {
                    self?.listener?.didTabReadMoreButton(url: curArticle.url)
                }
            }.store(in: &subscriptions)        
    }
    
    func update(total: ArticleTotalEntity, startPageIndex: Int) {
        totalEntity = total
        if let index = indexSubject.value {
            indexSubject.send(index + 1)
        }else {
            indexSubject.send(startPageIndex)
        }
    }
    
    func config(article: ArticleEntity){
        setNavigationTitle(title: article.source.name ?? "")
        titleLabel.text = article.title
        subTitleLabel.text = article.description
        dateLabel.text = article.publishedAt.changeFormat(formatType: .total(date: .hyphen, time: .full))
        authorLabel.text = article.author
        contentLabel.text = article.content
        
        let content = article.content.components(separatedBy: "… [+")
        
        if content.count > 1 {
            contentLabel.text = "\(content.first!)... [더보기]"
            contentLabel.setAttributeText(style: .init(font: .semibold14,
                                                       hasUnderline: true,
                                                       targetText: "[더보기]",
                                                      lineSpacing: 3)
            )
            readMoreButton.isHidden = false
        }else {
            contentLabel.text = article.content
            contentLabel.setAttributeText(style: .init(font: .semibold12,
                                                       hasUnderline: false,
                                                       targetText: article.content,
                                                      lineSpacing: 3))
            readMoreButton.isHidden = true
        }
        
        contentImageView.kf.setImage(with: URL(string: article.urlToImage)) {[weak self] result in
            guard let weakSelf = self else { return }
            
            switch result {
            case .success(let value):
                let deviceWidth = CGFloat(UIScreen.main.bounds.width)
                let newHeight = (deviceWidth * value.image.size.height) / value.image.size.width
                weakSelf.contentImageView.snp.updateConstraints {
                    $0.height.equalTo(newHeight)
                }
                break
            default:
                break
            }
        }
    }
    
    func reset(){
        setNavigationTitle(title: "")
        titleLabel.text = ""
        subTitleLabel.text = ""
        dateLabel.text = ""
        authorLabel.text = ""
        contentLabel.text = ""
        contentImageView.image = nil
    }
    
    func showAlert(message: String) {
        CustomAlert.showAlert(rootVC: self,
                              alertMessage: message,
                              hasCancelButton: false,
                              cancelActionClosure: { },
                              confirmActionClosure: { }
        )
    }
    
    @objc
    private func didTapBackButton() {
        listener?.didTapBackButton(index: indexSubject.value ?? 0)
    }
}
