/**
 @class NewsMainInteratorTest
 @date
 @writer kimsoomin
 @brief
 @update history
 -
 */
@testable import NewsMain
import XCTest
import NewsDataModel

final class NewsMainTest: XCTestCase {

    private var sut: NewsMainInteractor!    
    private var router: NewsMainRouterMock!
    private var presenter: NewsMainViewControllerMock!
    private var dependency: NewsMainInteractorDependencyMock!
    
    private var newsRepositoryMock: NewsRepositoryImpMock {
        dependency.newsRepository as! NewsRepositoryImpMock
    }
    
    
    override func setUpWithError() throws {
        super.setUp()

        self.dependency = NewsMainInteractorDependencyMock()
        self.presenter = NewsMainViewControllerMock()
        
        sut = NewsMainInteractor(
            presenter: self.presenter,
            depengency: self.dependency
        )
    }
    
    func test_success_fetch_articles() {
    
        //given
        dependency.newsRepository.fetchArticles(curPage: 1)
        //when
        sut.activate()
        
        //then
        XCTAssertEqual(presenter.updateCallCount, 1)
        XCTAssertEqual(presenter.dataSourceCount, 1)
    }
    
    func test_fail_fetch_articles() {
    
        //given
        dependency.newsRepository.fetchArticles(curPage: 0)
        //when
        sut.activate()
        
        //then
        XCTAssertEqual(presenter.updateCallCount, 0)
        XCTAssertEqual(presenter.dataSourceCount, 0)
        XCTAssertEqual(presenter.showAlertCallCount, 1)
    }
    
    func test_router_attach_child() {
    
        //given
        dependency.newsRepository.fetchArticles(curPage: 1)
        //when
        sut.activate()
        
        presenter.listener?.didSelectArticle(index: 0)
        //then
        XCTAssertEqual(router.attachNewsDetailCallCount, 1)
    }        

    override func tearDownWithError() throws {
        
    }

    func testExample() throws {
        
    }
}
