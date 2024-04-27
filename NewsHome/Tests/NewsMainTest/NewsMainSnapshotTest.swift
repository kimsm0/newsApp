import Foundation
import XCTest
@testable import NewsMain

import NewsDataModel
import SnapshotTesting
import NewsTestSupport

final class NewsMainSnapshotTest: XCTestCase {
    
    func testNewsMain(){
        let sut = NewsMainViewController()
        
        let testData = TestDouble.getArticleTotalDTO(2).toEntity()
        sut.update(with: testData.articles)
        
        assertSnapshots(of: sut, as: [.image])
    }
    
}
