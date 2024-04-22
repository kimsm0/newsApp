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
   
}

final class NewsMainViewController: UIViewController, NewsMainPresentable, NewsMainViewControllable {

    weak var listener: NewsMainPresentableListener?
    
    
    private var dataSource: [ArticleEntity] = []
    
    private lazy var tableView =  UITableView().then{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.dataSource = self
        $0.delegate = self
        $0.register(NewsMainTopNewsCell.self, forCellReuseIdentifier: "NewsMainTopNewsCell")
        $0.register(NewsMainNewsCell.self, forCellReuseIdentifier: "NewsMainNewsCell")
        $0.rowHeight = UITableView.automaticDimension
        $0.separatorInset = .zero
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layout()
    }
    
    func layout(){
        view.addSubview(tableView)
            
        tableView.snp.makeConstraints{
            $0.leading.top.trailing.bottom.equalToSuperview()
        }
    }
    
    func update(with dataSource: [ArticleEntity]) {
      self.dataSource = dataSource
      tableView.reloadData()
    }
    
}

extension NewsMainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let topCell = tableView.dequeueReusableCell(withIdentifier: "NewsMainTopNewsCell", for: indexPath) as? NewsMainTopNewsCell
        return topCell ?? UITableViewCell()
    }
}
