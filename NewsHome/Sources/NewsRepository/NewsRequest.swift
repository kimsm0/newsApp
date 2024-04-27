/**
 @class NewsRequest
 @date 4/21/24
 @writer kimsoomin
 @brief
 @update history
 -
 */
import Foundation
import Network
import NewsDataModel
import Common

struct NewsRequest: Request {
    typealias Output = ArticleTotalDTO
    
    var endpoint: URL
    var method: HTTPMethod
    var query: QueryItems
    var header: HTTPHeader
    
    init(baseURL: URL,
         curPage: Int
    ){
        self.endpoint = baseURL.appendingPathComponent(APIPath.newsPath)
        self.method = .get        
        self.query = [
            "apiKey": APIPath.API_KEY,
            "country": "us",
            "pageSize": Pagination.newsPagination,
            "page": curPage
        ]
        self.header = [:]
    }
}

