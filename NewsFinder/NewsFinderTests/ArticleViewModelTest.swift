//
//  ArticleViewModelTest.swift
//  NewsFinder
//
//  Created by Ahmed Shaban on 07/06/2023.
//

@testable import NewsFinder
import XCTest

class ArticleViewModelTests: XCTestCase {
        
    var viewModel: ArticleViewModel!

    
    override func setUp() {
        super.setUp()
        viewModel = ArticleViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testFetchArticles() {

        let viewModel = ArticleViewModel()

        viewModel.fetchArticles(page: 1)
        
        XCTAssertNotEqual(viewModel.allArticles["Business"]?.count, 0, "Number of articles should not be zero")
    }
}
