//
//  File.swift
//  
//
//  Created by kimsoomin_mac2022 on 4/27/24.
//

import Foundation
@testable import NewsMain
import ModernRIBs
import NewsDetail

final class NewsMainRouterMock: ViewableRouter<NewsMainInteractable, NewsMainViewControllable> {
        
    public var attachNewsDetailCallCount = 0
    public var detachNewsDetailCallCount  = 0
    
    override init(interactor: NewsMainInteractable,
         viewController: NewsMainViewControllable
    ) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

extension NewsMainRouterMock: NewsMainRouting {
    /**
     @brief 하위 리블렛 attach
     */
    func attachNewsDetail(selectedIndex: Int) {
        attachNewsDetailCallCount += 1
    }
    
    /**
     @brief 하위 리블렛 detach
     */
    func detachNewsDetail() {
        detachNewsDetailCallCount += 1
    }
}
