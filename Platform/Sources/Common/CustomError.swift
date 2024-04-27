/**
 @class CustomError
 @date 4/21/24
 @writer kimsoomin
 @brief
 @update history
 -
 */
import Foundation

public enum NetworkError: Error {
    case invalidError
    case invalidURL(url: String?)
    case error(Error)
    case networkConnectError
    
    public var customCode: String {
        switch self {
        case .invalidError:
            return "#NE-001"
        case .invalidURL(_):
            return "#NE-002"
        case .error(_):
            return "#NE-003"
        case .networkConnectError:
            return "#NE-004"
        }
    }
}


