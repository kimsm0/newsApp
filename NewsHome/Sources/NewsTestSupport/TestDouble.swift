//
//  File.swift
//  
//
//  Created by kimsoomin_mac2022 on 4/27/24.
//

import Foundation
import Extensions
import NewsDataModel

public enum NewsTestMode{
    case main
    case detail
}

public struct TestDouble {
    public static var testMode: NewsTestMode = .main
    
    public static func getArticleDTO(_ with: Int) -> ArticleDTO {
        .init(source: getSourceDTO(with),
              author: "test_author",
              title: "test_title",
              description: "A Black man in Ohio, Frank Tyson, seen handcuffed and facedown on a bar floor in the video, died in police custody. Officers involved have been placed on paid administrative leave.",
              url: "https://www.cbsnews.com/news/frank-tyson-toledo-police-body-cam-video-handcuffed-facedown-bar-floor/",
              urlToImage: "https://assets3.cbsnewsstatic.com/hub/i/r/2024/04/26/8bcc1ed2-ebdc-440a-9448-69ffc793f808/thumbnail/1200x630/d5534e40f47af7cd8dce4011800ab24d/ap24116535072336.jpg?v=63c131a0051f3823d92b0d1dffb5e0e4",
              publishedAt: "2024-04-26T14:11:03Z",
              content: "Toledo, Ohio — An Ohio man who was handcuffed and left facedown on the floor of a social club last week died in police custody, and the officers involved have been placed on paid administrative leave… [+4680 chars]")
    }
    public static func getSourceDTO(_ with: Int) -> SourceDTO {
        .init(id: "test_id",
              name: "test_name")
    }
    public static func getArticleTotalDTO(_ with: Int) -> ArticleTotalDTO {
        var articles: [ArticleDTO] = []
        for i in 0..<with {
            articles.append(getArticleDTO(i))
        }
        return .init(totalResults: with, articles: articles)
    }
    
    public static func getArticleTotalDic(_ with: Int) -> [String: Any] {
        
        do {
            let dic = try getArticleTotalDTO(with).encode()
            return dic
        }catch {
            return [:]
        }
    }
}
