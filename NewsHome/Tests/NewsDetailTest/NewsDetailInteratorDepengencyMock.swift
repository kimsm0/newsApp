//
//  File.swift
//
//
//  Created by kimsoomin_mac2022 on 4/26/24.
//

import Foundation
@testable import NewsDetail
import NewsRepository
import CombineSchedulers
import NewsTestSupport
import WebView

final class NewsDetailInteratorDepengencyMock: NewsDetailInteractorDependency, WebViewDependency {
    var startPageIndex: Int{
        return 1
    }
    var mainQueue: AnySchedulerOf<DispatchQueue>{
        .immediate
    }
    var newsRepository: NewsRepository
    
    init(testCount: Int){
        self.newsRepository = NewsRepositoryImpMock(testCount: testCount)
    }
}
