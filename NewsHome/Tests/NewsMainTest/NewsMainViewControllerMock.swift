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
import Common

final class NewsMainViewControllerMock: UIViewController, NewsMainPresentable, NewsMainViewControllable {
    
    weak var listener: NewsMainPresentableListener?
    
    private var dataSource: [ArticleEntity] = []
    
    public var dataSourceCount: Int {
        dataSource.count
    }
    public var updateCallCount = 0
    
    func update(with dataSource: [ArticleEntity]) {
        self.updateCallCount += 1
        self.dataSource = dataSource
        printLog("update \(updateCallCount) \(dataSource.count)")
    }
    
    public var scrollToLastArticleCallCount = 0
    func scrollToLastArticle(index: Int) {
        self.scrollToLastArticleCallCount += 1
        printLog("scrollToLastArticle \(scrollToLastArticleCallCount)")
    }
    
    public var showAlertCallCount = 0
    func showAlert(message: String) {
        self.showAlertCallCount += 1
        printLog("showAlertCallCount \(showAlertCallCount)")
    }
    
}


