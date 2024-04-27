/**
 @class NewsMainTest
 @date
 @writer kimsoomin
 @brief
 @update history
 -
 */
@testable import NewsMain
import XCTest
import NewsDataModel
import NewsTestSupport

final class NewsMainTest: XCTestCase {

    private var sut: NewsMainInteractor!    
    private var router: NewsMainRouterMock!
    private var presenter: NewsMainViewControllerMock!
    private var dependency: NewsMainInteractorDependencyMock!
    
    private let testCount = 2
    
    private var newsRepositoryMock: NewsRepositoryImpMock {
        dependency.newsRepository as! NewsRepositoryImpMock
    }
        
    override func setUpWithError() throws {
        super.setUp()

        self.dependency = NewsMainInteractorDependencyMock(testCount: testCount)
        self.presenter = NewsMainViewControllerMock()
        
        
        let interator = NewsMainInteractor(
            presenter: self.presenter,
            depengency: self.dependency
        )
        self.router = NewsMainRouterMock(interactor: interator, viewController: presenter)
                
        interator.router = self.router
        sut = interator
    }
    
    /*
     active -> curPage1 API request
     test data 2개 확인
     */
    func test_success_fetchNewsList() {
        //given
        
        //when
        sut.activate()
        
        //then
        XCTAssertEqual(presenter.updateCallCount, 1)
        XCTAssertEqual(presenter.dataSourceCount, testCount)
    }
    
    /*
     ative 후에 repo 재호출하여 데이터 갱신 후 error 로직 확인
     */
    func test_fail_fetchNewsList() {
        //given
        sut.activate()
        
        //when
        dependency.newsRepository.fetchArticles(curPage: 0)
        
        //then
        XCTAssertEqual(presenter.showAlertCallCount, 1)
    }
    
    func test_didSelectArticle() {
    
        //given
        sut.activate()
        //when
        presenter.listener?.didSelectArticle(index: 0)
        //then
        XCTAssertEqual(router.attachNewsDetailCallCount, 1)
    } 
    
    /*
     testcount = test articles cocunt
     loadmore를 테스트하기 위해 curPage: -1 을 임의로 호출하여 totalCount/articles count를 조정함.
     */
    func test_loadMore() {
    
        //given
        sut.activate()
        //when
        dependency.newsRepository.fetchArticles(curPage: -1) //loadmore 가 호출될 수 있게 count 조정용 호출
        presenter.listener?.loadMore(index: 0)
        //then
        XCTAssertEqual(presenter.updateCallCount, 3)
        XCTAssertEqual(presenter.dataSourceCount, testCount)
    }

    override func tearDownWithError() throws {
        
    }

    func testExample() throws {
        
    }
}
