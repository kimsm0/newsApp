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
import Extensions

public typealias APIPath = Constant.APIPath
public typealias Pagination = Constant.Pagination

public enum Constant {}

public extension Constant {
    struct APIPath{
        public static let API_KEY = "2e5866705ef741519082fb8f92136cb8"
        public static let newsPath = "top-headlines"
    }
}

public extension Constant {
    struct Pagination {
        public static let newsPagination = 10
    }
}


public func printLog(_ log: Any?, file: String = #file, funcName: String = #function, line: Int = #line){
    let fileName = (file as NSString).lastPathComponent
    let debugLog = " 🍏\n 💡FILE = \(fileName)\n 💡FUNC = \(funcName)\n 💡LINE = \(line)\n 💡LOG = \(log ?? "NULL") \n 💡TIME = \(Date().convertToString(formatType: .total(date: .slash, time: .full24)))\n"
    print(debugLog)
}


public func apiLog(url: String?, resultCode: Int?){
    print("\n  🛜\n  API RESULT \n  URL: \(url ?? "nil") \n  RESULT CODE: \(String(describing: resultCode ?? 0))\n  🛜")
}
