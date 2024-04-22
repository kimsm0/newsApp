/**
 @class
 @date 4/21/24
 @writer kimsoomin
 @brief
 @update history
 -
 */
import Combine
import Foundation

public enum HTTPMethod: String, Encodable {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
}

public typealias QueryItems = [String: AnyHashable]
public typealias HTTPHeader = [String: String]

public protocol Request: Hashable {
  associatedtype Output: Decodable
  
  var endpoint: URL { get }
  var method: HTTPMethod { get }
  var query: QueryItems { get }
  var header: HTTPHeader { get }
}

public struct Response<T: Decodable> {
  public let output: T
  public let statusCode: Int
  
  public init(output: T, statusCode: Int) {
    self.output = output
    self.statusCode = statusCode
  }
}

public protocol Network {
  func send<T: Request>(_ request: T) -> AnyPublisher<Response<T.Output>, Error>
}
