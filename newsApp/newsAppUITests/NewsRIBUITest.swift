//
//  NewsRIBUITest.swift
//  newsAppUITests
//
//  Created by kimsoomin_mac2022 on 4/27/24.
//

import Foundation
import XCTest
import Extensions
import NewsTestSupport

final class NewsRIBUITest: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
    }

    func test_news_main_detail() throws {
        app.launch()
        
        XCTAssertTrue(isDisplayed(app.staticTexts["Top Stories"]))
        

        let tableView = app.tables["newsmain_tableview"]
        tableView.swipeUp()
        
        /*
         메인 뉴스 화면 네비게이션바 타이틀에는 오늘 날짜 노출 
         */
        XCTAssertTrue(isDisplayed(app.navigationBars[Date().convertToString(formatType: .date(date: .dot))]))
        /*
         메인 뉴스 화면 네비게이션바 왼쪽에는 텍스트로 "News"
         */
        XCTAssertTrue(isDisplayed(app.navigationBars.staticTexts["News"]))
        
        let testTotal = TestDouble.getArticleTotalDTO(2).toEntity()
        let testTopArticle = testTotal.articles.first!
        let testArticle = testTotal.articles[safe: 1]!
        
        /*
         메인 뉴스 화면 A타입(top)
         */
        XCTAssertTrue(isDisplayed(app.images["newsmain_top_image"]))
        XCTAssertTrue(isDisplayed(app.staticTexts["newsmain_top_publisher"]))
        XCTAssertTrue(isDisplayed(app.staticTexts["newsmain_top_title"]))
        XCTAssertTrue(isDisplayed(app.staticTexts["newsmain_top_date"]))
        XCTAssertTrue(isDisplayed(app.staticTexts["newsmain_top_author"]))
        
        /*
         메인뉴스 리스트 A타입 신문사
         */
        XCTAssertEqual(app.staticTexts["newsmain_top_publisher"].label, testTopArticle.source.name)
        /*
         메인뉴스 리스트 A타입 타이틀
         */
        XCTAssertEqual(app.staticTexts["newsmain_top_title"].label, testTopArticle.title)
        /*
         메인뉴스 리스트 A타입 날짜
         */
        XCTAssertEqual(app.staticTexts["newsmain_top_date"].label, testTopArticle.publishedAt)
        /*
         메인뉴스 리스트 A타입 기자명
         */
        XCTAssertEqual(app.staticTexts["newsmain_top_author"].label, testTopArticle.author)

        /*
         메인 뉴스 화면 B타입
         */
        XCTAssertTrue(isDisplayed(app.images["newsmain_image"]))
        XCTAssertTrue(isDisplayed(app.staticTexts["newsmain_publisher"]))
        XCTAssertTrue(isDisplayed(app.staticTexts["newsmain_title"]))
        XCTAssertTrue(isDisplayed(app.staticTexts["newsmain_date"]))
        XCTAssertTrue(isDisplayed(app.staticTexts["newsmain_author"]))
        
                        
        /*
         메인 뉴스 화면 B타입
         */
        XCTAssertEqual(app.staticTexts["newsmain_publisher"].label, testArticle.source.name)
        
        /*
         메인 뉴스 화면 B타입
         */
        XCTAssertEqual(app.staticTexts["newsmain_title"].label, testArticle.title)
        
        /*
         메인 뉴스 화면 B타입
         */
        XCTAssertEqual(app.staticTexts["newsmain_date"].label, testArticle.publishedAt)
        
        /*
         메인 뉴스 화면 B타입
         */
        XCTAssertEqual(app.staticTexts["newsmain_author"].label, testArticle.author)
        
        
        
        /*
         뉴스를 탭하면 상세화면으로 이동
         */
        tableView.cells.element(boundBy: 0).tap()        
        /*
         상세화면에서 네비게이션바 타이틀에는 신문사 명 노출
         */
        XCTAssertTrue(isDisplayed(app.navigationBars.staticTexts["test_name"]))
        
                
        //상세 화면 노출 확인
        XCTAssertTrue(isDisplayed(app.images["newsdetail_image"]))
        XCTAssertTrue(isDisplayed(app.staticTexts["newsdetail_title"]))
        XCTAssertTrue(isDisplayed(app.staticTexts["newsdetail_description"]))
        XCTAssertTrue(isDisplayed(app.staticTexts["newsdetail_author"]))
        XCTAssertTrue(isDisplayed(app.staticTexts["newsdetail_date"]))
        XCTAssertTrue(isDisplayed(app.staticTexts["newsdetail_content"]))
        
        
        /*
         선택한 뉴스의 타이틀
         */
        XCTAssertEqual(app.staticTexts["newsdetail_title"].label, testTopArticle.title)
        
        /*
         선택한 뉴스의 서브타이틀
         */
        XCTAssertEqual(app.staticTexts["newsdetail_description"].label, testTopArticle.description)
        
        /*
         선택한 뉴스의 기자명
         */
        XCTAssertEqual(app.staticTexts["newsdetail_author"].label, testTopArticle.author)
        
        /*
         선택한 뉴스의 작성시간
         */
        XCTAssertEqual(app.staticTexts["newsdetail_date"].label, testTopArticle.publishedAt)
        
        /*
         선택한 뉴스의 기사내용
         */
        let content = app.staticTexts["newsdetail_content"].label
        let contentFrist = content.components(separatedBy: "… [+").first
        let testContentFirst = testTopArticle.content.components(separatedBy: "… [+").first
        XCTAssertNotNil(contentFrist)
        XCTAssertNotNil(testContentFirst)
        XCTAssertTrue(contentFrist!.contains(testContentFirst!))
        
        /*
         하단바 이전기사/다음기사 버튼 영역 
         */
        XCTAssertTrue(isDisplayed(app.buttons["moveButtonView_pre_button"]))
        XCTAssertTrue(isDisplayed(app.buttons["moveButtonView_next_button"]))
        
        
        /*
         더보기 버튼
         */
        app.buttons["newwdetail_more_button"].tap()
        XCTAssertTrue(isDisplayed(app.webViews["webviewController_webview"]))                
    }
}
