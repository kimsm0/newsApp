/**
 @class NewsMainViewController
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
import Extensions
import NewsDataModel

protocol NewsMainPresentableListener: AnyObject {
    func didSelectArticle(index: Int)
    func loadMore(index: Int)
}

final class NewsMainViewController: UIViewController, NewsMainPresentable, NewsMainViewControllable {

    weak var listener: NewsMainPresentableListener?    
    
    private var dataSource: [ArticleEntity] = []
    
    private lazy var tableView =  UITableView(frame: .zero, style: .grouped).then{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.dataSource = self
        $0.delegate = self
        $0.register(NewsTitleHeaderView.self,
                    forHeaderFooterViewReuseIdentifier: "NewsTitleHeaderView")
        $0.register(NewsMainTopNewsCell.self,
                    forCellReuseIdentifier: "NewsMainTopNewsCell")
        $0.register(NewsMainNewsCell.self, 
                    forCellReuseIdentifier: "NewsMainNewsCell")
        $0.rowHeight = UITableView.automaticDimension
        $0.separatorInset = .zero
        $0.backgroundColor = .white
        $0.showsVerticalScrollIndicator = false 
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupNavigationItem(left: .text("News"),
                                 title: Date().convertToString(formatType: .date(date: .dot)),
                                 target: nil,
                                 action: nil)
    }
    
    func layout(){        
        view.addSubview(tableView)            
        tableView.snp.makeConstraints{
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)            
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
    
    func update(with dataSource: [ArticleEntity]) {
      self.dataSource = dataSource
      tableView.reloadData()
    }
    
    func scrollToLastArticle(index: Int) {
        self.tableView.scrollToRow(at: IndexPath(row: index, section: 0), at: .middle, animated: false)
    }
}

extension NewsMainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let topCell = tableView.dequeueReusableCell(withIdentifier: "NewsMainTopNewsCell", for: indexPath) as? NewsMainTopNewsCell
            topCell?.config(article: dataSource[indexPath.row])
            return topCell ?? UITableViewCell()
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsMainNewsCell", for: indexPath) as? NewsMainNewsCell
            cell?.config(article: dataSource[indexPath.row])
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listener?.didSelectArticle(index: indexPath.row)        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return tableView.dequeueReusableHeaderFooterView(withIdentifier: "NewsTitleHeaderView")
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 50
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if dataSource.count - 2 == indexPath.row {
            listener?.loadMore(index: indexPath.row)
        }
    }
}
