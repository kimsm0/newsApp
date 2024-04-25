/**
 @class NewsRepository
 @date 4/21/24
 @writer kimsoomin
 @brief
 @update history
 -
 */
import Foundation
import Combine
import Utils
import Network
import NewsDataModel

public protocol NewsRepository {
    var articleTotalResult: ReadOnlyCurrentValuePublisher<ArticleTotalEntity> { get }
    func fetchArticles(curPage: Int)
}

public final class NewsRepositoryImp: NewsRepository {
    public var articleTotalResult: ReadOnlyCurrentValuePublisher<ArticleTotalEntity> {
        articleTotalSubject
    }
    
    private let articleTotalSubject = CurrentValuePublisher<ArticleTotalEntity>(.init(status: "", totalResults: 0, articles: []))
    
    
    private let network: Network
    private let baseURL: URL
    private var subscriptions: Set<AnyCancellable>
    public init(network: Network, baseURL: URL){
        self.subscriptions = .init()
        self.network = network
        self.baseURL = baseURL
    }
}

public extension NewsRepositoryImp {
    func fetchArticles(curPage: Int) {
        let request = NewsRequest(baseURL: baseURL, curPage: curPage)
         network
            .send(request)
            .map(\.output)
            .handleEvents(receiveOutput: { output in
                var newEntity = output.toEntity()
                var preValue = self.articleTotalSubject.value.articles
                preValue.append(contentsOf: output.articles.map{ $0.toEntity() })
                newEntity.articles = preValue
                self.articleTotalSubject.send(newEntity)
            })
            .sink(receiveCompletion: {_ in }, receiveValue: { _ in })
            .store(in: &subscriptions)
            
    }
}
