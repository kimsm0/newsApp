/**
 @class NewsDetailTest
 @date
 @writer kimsoomin
 @brief
 @update history
 -
 */
@testable import NewsDetail
import XCTest
import NewsDataModel
import NewsTestSupport
import WebView

final class NewsDetailTest: XCTestCase {

    private var sut: NewsDetailInteractor!
    private var router: NewsDetailRouter!
    private var presenter: NewsDetailViewControllerMock!
    private var dependency: NewsDetailInteratorDepengencyMock!
    private var listener: NewsDetailListenerMock!
    
    private let testCount = 2
    
    private var newsRepositoryMock: NewsRepositoryImpMock {
        dependency.newsRepository as! NewsRepositoryImpMock
    }
        
    override func setUpWithError() throws {
        super.setUp()

        self.dependency = NewsDetailInteratorDepengencyMock(testCount: testCount)
        self.presenter = NewsDetailViewControllerMock()
        self.listener = NewsDetailListenerMock()
        
        let interator = NewsDetailInteractor(
            presenter: self.presenter,
            depengency: self.dependency
        )
        
        let webViewBuildable = WebViewBuilder(dependency: self.dependency)
        
        self.router = NewsDetailRouter(interactor: interator,
                                       viewController: presenter,
                                       webViewBuildable: webViewBuildable)
                
        interator.router = self.router
        interator.listener = self.listener
        sut = interator
    }
    
    /*
     상세 데이터가 있는 경우, presenter로 화면 update가 정상적으로 호출되는지 확인
     */
    func test_success(){
        //given
        dependency.newsRepository.fetchArticles(curPage: 1)
        //when
        sut.activate()
        
        //then
        XCTAssertEqual(presenter.updateCallCount, 1)
        XCTAssertEqual(presenter.totalEntityCount, testCount)
    }
    
    /*
     상세 데이터가 없는 경우, presenter로 오류 메시지 출력 함수가 정상 호출되는지 확인
     */
    func test_fail(){
        //given
        dependency.newsRepository.fetchArticles(curPage: 0)
        //when
        sut.activate()
        
        //then
        XCTAssertEqual(presenter.showAlertCallCount, 1)
    }
    
    /*
     상세화면에서 navigation back 버튼 탭하면 메인 목록화면에서 해당 기사가 가운데 위치하도록 index값이 제대로 넘어오는지 확인 
     */
    func test_didTapBackButton(){
        
        sut.didTapBackButton(index: 0)
        XCTAssertEqual(listener.detachNewsDetailCallCount, 1)
        XCTAssertEqual(listener.lastArticleIndex, 0)
    }
    
    /*
     상세화면 하단 버튼으로 상위 리블렛(메인)의 loadmore 정상 호출되는지 확인
     */
    func test_loadMoreFromDetail(){
        sut.loadMoreFromDetail()
        XCTAssertEqual(listener.loadMoreFromDetailCallCount, 1)
    }

    override func tearDownWithError() throws {
        
    }

    func testExample() throws {
        
    }
}
