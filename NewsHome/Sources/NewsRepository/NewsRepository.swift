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
import Common
import CustomUI

public protocol NewsRepository {
    var articleTotalResult: ReadOnlyCurrentValuePublisher<ArticleTotalEntity> { get }
    var resultError: ReadOnlyCurrentValuePublisher<NetworkError?> { get }
    func fetchArticles(curPage: Int)
}

public final class NewsRepositoryImp: NewsRepository {
    public var articleTotalResult: ReadOnlyCurrentValuePublisher<ArticleTotalEntity> {
        articleTotalSubject
    }
    
    private let articleTotalSubject = CurrentValuePublisher<ArticleTotalEntity>(.init(status: "", totalResults: 0, articles: []))
    
    public var resultError: ReadOnlyCurrentValuePublisher<NetworkError?> {
        resultErrorSubject
    }
    
    private let resultErrorSubject = CurrentValuePublisher<NetworkError?>(nil)
    
    
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
        LoadingView.showLoading()
        let request = NewsRequest(baseURL: baseURL, curPage: curPage)
         network
            .send(request)
            .map(\.output)
            .handleEvents(receiveOutput: { output in
                LoadingView.hideLoading()
                var newEntity = output.toEntity()
                var preValue = self.articleTotalSubject.value.articles
                preValue.append(contentsOf: output.articles.map{ $0.toEntity() })
                newEntity.articles = preValue
                self.articleTotalSubject.send(newEntity)
            }, receiveCompletion: { completion in
                LoadingView.hideLoading()
                if case let .failure(error) = completion {
                    printLog(error.localizedDescription)
                    self.resultErrorSubject.send(NetworkError.error(error))
                }
            })
            .sink(receiveCompletion: {_ in }, receiveValue: { _ in })
            .store(in: &subscriptions)
            
    }
}
