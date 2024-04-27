//
//  File.swift
//  
//
//  Created by kimsoomin_mac2022 on 4/27/24.
//

import Foundation
@testable import NewsDetail


public final class NewsDetailListenerMock: NewsDetailListener {
    var detachNewsDetailCallCount = 0
    var lastArticleIndex: Int?
    
    public func detachNewsDetail(lastArticleIndex: Int) {
        detachNewsDetailCallCount += 1
        self.lastArticleIndex = lastArticleIndex
    }
    
    var loadMoreFromDetailCallCount = 0
    public func loadMoreFromDetail() {
        loadMoreFromDetailCallCount += 1
    }
}
