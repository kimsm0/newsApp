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

final class NewsDetailInteratorDepengencyMock: NewsDetailInteractorDependency {
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
