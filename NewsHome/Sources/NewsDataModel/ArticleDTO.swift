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
public struct ArticleTotalDTO: Codable {
    public let totalResults: Int?
    public var articles: [ArticleDTO] = []
    
    public init(
        totalResults: Int,
        articles: [ArticleDTO]
    ) {
        self.totalResults = totalResults
        self.articles = articles
    }
    
    public func toEntity() -> ArticleTotalEntity {
        
        return ArticleTotalEntity(
            status: "",
            totalResults: self.totalResults ?? 0,
            articles: self.articles.map{$0.toEntity()}
        )
    }
}

// MARK: - Article
public struct ArticleDTO: Codable {
    public let source: SourceDTO
    public let author: String?
    public let title: String?
    public let description: String?
    public let url: String?
    public let urlToImage: String?
    public let publishedAt: String?
    public let content: String?
    
    public init(
        source: SourceDTO,
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
    
    public func toEntity() -> ArticleEntity {
        
        return ArticleEntity(
            source: self.source.toEntity(),
            author: self.author ?? "",
            title: self.title ?? "",
            description: self.description ?? "",
            url: self.url ?? "",
            urlToImage: self.urlToImage ?? "",
            publishedAt: self.publishedAt ?? "",
            content: self.content ?? ""
        )
    }
}

// MARK: - Source
public struct SourceDTO: Codable {
    public let id: String?
    public let name: String?
    
    public init(
        id: String?,
         name: String?
    ) {
        self.id = id
        self.name = name
    }
    
    public func toEntity() -> SourceEntity {
        
        return SourceEntity(
            id: self.id ?? "",
            name: self.name ?? ""
        )
    }
}

