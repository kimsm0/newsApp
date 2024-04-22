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
    case invalidURL(url: String?)
    case error(Error)
}


