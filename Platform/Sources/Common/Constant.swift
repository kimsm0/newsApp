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
        public static var API_KEY: String {
            if let path = Bundle.main.path(forResource: "KEYs", ofType: "plist"), let dic = NSDictionary(contentsOfFile: path){
                return dic["API_KEY"] as? String ?? ""
            }
            return ""
        }
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
    let debugLog = "\n🍏\n💡FILE = \(fileName)\n💡FUNC = \(funcName)\n💡LINE = \(line)\n💡LOG = \(log ?? "NULL") \n💡TIME = \(Date().convertToString(formatType: .total(date: .slash, time: .full24)))\n🍏\n"
    print(debugLog)
}


public func apiLog(url: String?, resultCode: Int?, message: Data? = "".data(using: .utf8)){
    let urlString = "\n💡URL = \(url ?? "nil")"
    let codeString = "\n💡RESULT CODE = \(resultCode ?? 0)"
    let messageString = "\n💡RESULT = \(String(decoding: message!, as: UTF8.self))"
    
    if resultCode == 200 {
        print("\n🛜\(urlString)\(codeString)\n🛜")
    }else {
        print("\n🛜\(urlString)\(codeString)\(messageString)\n🛜")
    }
}
