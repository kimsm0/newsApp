//
//  File.swift
//  
//
//  Created by kimsoomin_mac2022 on 4/26/24.
//
import Foundation
import NewsRepository
import Utils
import NewsDataModel
import Common
import NewsTestSupport

public final class NewsRepositoryImpMock: NewsRepository {
    
    public var articleTotalResult: ReadOnlyCurrentValuePublisher<ArticleTotalEntity> {
        articleTotalSubject
    }
    
    private let articleTotalSubject = CurrentValuePublisher<ArticleTotalEntity>(.init(status: "", totalResults: 0, articles: []))
    
    public var resultError: ReadOnlyCurrentValuePublisher<NetworkError?> {
        resultErrorSubject
    }
    
    private let resultErrorSubject = CurrentValuePublisher<NetworkError?>(nil)  
    
    private var testCount = 0
    public init(testCount: Int){
        self.testCount = testCount
    }
}

public extension NewsRepositoryImpMock {
    
    func fetchArticles(curPage: Int) {        
        if curPage > 0  {
            let test = TestDouble.getArticleTotalDTO(testCount).toEntity()
            self.articleTotalSubject.send(test)
        }else if curPage == 0 {
            self.resultErrorSubject.send(NetworkError.invalidError)
        }else {
            let test = TestDouble.getArticleDTO(1)
            var preValue = self.articleTotalSubject.value
            preValue.articles = [test.toEntity()]
            self.articleTotalSubject.send(preValue)
        }
    }
}
