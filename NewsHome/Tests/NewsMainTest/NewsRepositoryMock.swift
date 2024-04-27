//
//  File.swift
//  
//
//  Created by kimsoomin_mac2022 on 4/26/24.
//
import Foundation
import NewsRepository
import Combine
import Utils
import Network
import NewsDataModel
import Common

public final class NewsRepositoryImpMock: NewsRepository {
    
    public var articleTotalResult: ReadOnlyCurrentValuePublisher<ArticleTotalEntity> {
        articleTotalSubject
    }
    
    private let articleTotalSubject = CurrentValuePublisher<ArticleTotalEntity>(.init(status: "", totalResults: 0, articles: []))
    
    public var resultError: ReadOnlyCurrentValuePublisher<NetworkError?> {
        resultErrorSubject
    }
    
    private let resultErrorSubject = CurrentValuePublisher<NetworkError?>(nil)    
}

public extension NewsRepositoryImpMock {
    
    func fetchArticles(curPage: Int) {
        
        if curPage > 0  {
            let testArticle = ArticleTotalEntity.init(status: "", totalResults: 1, articles: [.init(source: .init(id: "", name: "test"), author: "test_author", title: "test_title", description: "test_description", url: "test_url", urlToImage: "test_urlToImage", publishedAt: "test_23.10.10", content: "test_content")])
            self.articleTotalSubject.send(testArticle)
        }else {
            self.resultErrorSubject.send(NetworkError.invalidError)
        }
    }
}
