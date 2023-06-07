//
//  ArticleLoaderTest.swift
//  NewsFinder
//
//  Created by Ahmed Shaban on 07/06/2023.
//

@testable import NewsFinder
import XCTest

class ArticleLoaderTests: XCTestCase {
    
    var articleLoader: ArticleLoader!
    
    override func setUp() {
        super.setUp()
        articleLoader = ArticleLoader()
    }
    
    override func tearDown() {
        articleLoader = nil
        super.tearDown()
    }

    
    func testFetchArticlesSuccess() {
        
        let loader = ArticleLoader()
                
        loader.fetchArticles(page: 1, category: "Business") { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
            case .failure:
                XCTFail("Fetch articles should succeed")
            }
        }
    }
}
