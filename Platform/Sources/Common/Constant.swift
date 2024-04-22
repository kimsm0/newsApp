/**
 @class Constant
 @date 4/21/24
 @writer kimsoomin
 @brief 공통으로 사용하는 데이터를 정의.
 -
 @update history
 -
 */
import Foundation
import Storage

public typealias APIPath = Constant.APIPath
public typealias Server = Constant.Server
public typealias API = Constant.API
public typealias Pagination = Constant.Pagination

public enum Constant {}

public extension Constant {
    enum Server: String {
        case develop
        case staging
        case product
    }
}

public extension Constant {
    struct API {
        static var serverMode: Server {
            guard let mode = UserDefaultsStorage.server else { return .product }
            return Server(rawValue: mode) ?? .product
        }
        public static var baseURL: String {
            #if UITESTING
            return "https://localhost:8080"
            #else
            switch serverMode {
            case .develop:
                return "https://newsapi.org/v2/"
            case .staging:
                return "https://newsapi.org/v2/"
            case .product:
                return "https://newsapi.org/v2/"
            }
            #endif
        }
    }
}

public extension Constant {
    struct APIPath{
        public static let newsPath = "top-headlines/"
    }
}

public extension Constant {
    struct Pagination {
        public static let newsPagination = 10
    }
}


