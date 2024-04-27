//
//  File.swift
//  newsApp
//
//  Created by kimsoomin_mac2022 on 4/27/24.
//

import Foundation
import NewsTestSupport

typealias Path = String
typealias MockResponse = (statusCode: Int, data: Data?)

final class AppURLProtocol: URLProtocol {
    
    static var successMock: [Path: MockResponse] = [:]
    static var failureErros: [Path: Error] = [:]
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let path = request.url?.path {
            if let mockResponse = AppURLProtocol.successMock[path] {
                client?.urlProtocol(self,
                                    didReceive: HTTPURLResponse(
                                        url: request.url!,
                                        statusCode: mockResponse.statusCode,
                                        httpVersion: nil,
                                        headerFields: nil)!,
                                    cacheStoragePolicy: .notAllowed)
                mockResponse.data.map { client?.urlProtocol(self, didLoad: $0)}
            }else if let error = AppURLProtocol.failureErros[path] {
                client?.urlProtocol(self, didFailWithError: error)
            }else {
                client?.urlProtocol(self, didFailWithError: MockSessionError.notSupported)
            }
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        
    }
    
}

enum MockSessionError: Error {
    case notSupported
}

func setupURLProtocol(){
    let articleResponse = TestDouble.getArticleTotalDic(2)
    let articleTotalResponse = try! JSONSerialization.data(withJSONObject: articleResponse, options: [])
    
    AppURLProtocol.successMock = [
        "/top-headlines": (200, articleTotalResponse),
    ]
}
