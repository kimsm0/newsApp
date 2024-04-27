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
    
//    let articleResponse: [String: Any] = [
//        "totalResults": 37,
//        "articles": [
//            [
//                "source": [
//                    "id": nil,
//                    "name": "TEST_PUBBLISHER"
//                ],
//            "author": nil,
//            "title": "Black man's death ",
//            "description": "A Black man ",
//            "url": "https://www.cbsnews.com/news/frank-tyson-toledo-police-body-cam-video-handcuffed-facedown-bar-floor/",
//            "urlToImage": "https://assets3.cbsnewsstatic.com/hub/i/r/2024/04/26/8bcc1ed2-ebdc-440a-9448-69ffc793f808/thumbnail/1200x630/d5534e40f47af7cd8dce4011800ab24d/ap24116535072336.jpg?v=63c131a0051f3823d92b0d1dffb5e0e4",
//            "publishedAt": "2024-04-26T14:11:03Z",
//            "content": "test"
//            ],
//            
//            
//        ]
//    ]
            
    
    let articleTotalResponse = try! JSONSerialization.data(withJSONObject: articleResponse, options: [])
    

    AppURLProtocol.successMock = [
        "/top-headlines": (200, articleTotalResponse),
    ]
}
