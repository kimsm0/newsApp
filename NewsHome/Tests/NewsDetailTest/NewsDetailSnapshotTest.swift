import Foundation
import XCTest
@testable import NewsDetail

import NewsDataModel
import SnapshotTesting
import NewsTestSupport

final class NewsDetailSnapshotTest: XCTestCase {
    
    func testNewsMain(){
        let sut = NewsDetailViewController()
        
        let testData = TestDouble.getArticleTotalDTO(2).toEntity()
        sut.update(total: testData, startPageIndex: 0)
        
        assertSnapshots(of: sut, as: [.image])
    }
}
