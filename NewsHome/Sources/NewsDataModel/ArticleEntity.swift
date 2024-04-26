/**
 @class 
 @date 4/21/24
 @writer kimsoomin
 @brief
 @update history
 -
 */
import Foundation

// MARK: - Total
public struct ArticleTotalEntity: Codable {
    public let status: String
    public let totalResults: Int
    public var articles: [ArticleEntity]
    public var hasMore: Bool {
        totalResults > articles.count
    }
    
    public init(
        status: String,
        totalResults: Int,
        articles: [ArticleEntity]
    ) {
        self.status = status
        self.totalResults = totalResults
        self.articles = articles
    }
}

// MARK: - Article
public struct ArticleEntity: Codable {
    public let source: SourceEntity
    public let author: String
    public let title: String
    public let description: String
    public let url: String
    public let urlToImage: String
    public let publishedAt: String
    public let content: String
    
    public init(
        source: SourceEntity,
         author: String,
         title: String,
         description: String,
         url: String,
         urlToImage: String,
         publishedAt: String,
         content: String
    ) {
        self.source = source
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
}

// MARK: - Source
public struct SourceEntity: Codable {
    public let id: String?
    public let name: String?
    
    public init(
        id: String,
         name: String
    ) {
        self.id = id
        self.name = name
    }        
}
