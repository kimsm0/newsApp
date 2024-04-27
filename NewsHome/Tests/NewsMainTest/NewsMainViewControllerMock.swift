//
//  File.swift
//  
//
//  Created by kimsoomin_mac2022 on 4/27/24.
//
@testable import NewsMain
import ModernRIBs
import UIKit
import SnapKit
import Then
import Extensions
import NewsDataModel
import CustomUI


final class NewsMainViewControllerMock: UIViewController, NewsMainPresentable, NewsMainViewControllable {
    
    weak var listener: NewsMainPresentableListener?
    
    private var dataSource: [ArticleEntity] = []
    
    public var dataSourceCount: Int {
        dataSource.count
    }
    public var updateCallCount = 0
    func update(with dataSource: [ArticleEntity]) {
        updateCallCount += 1
        self.dataSource = dataSource
        
    }
    
    public var scrollToLastArticleCallCount = 0
    func scrollToLastArticle(index: Int) {
        scrollToLastArticleCallCount += 1
    }
    
    public var showAlertCallCount = 0
    func showAlert(message: String) {
        showAlertCallCount += 1
    }
    
}


