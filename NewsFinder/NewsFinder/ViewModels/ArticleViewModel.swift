//
//  ArticleViewModel.swift
//  NewsFinder
//
//  Created by Ahmed Shaban on 07/06/2023.
//

import Alamofire

class ArticleViewModel: ObservableObject {
        
    @Published var allArticles: [String: [Article]] = [:]

    private let articleLoader = ArticleLoader()
    
    private let filters = ["Business", "Entertainment", "General", "Health", "Science", "Sports", "Technology"]
    
    func fetchArticles(page: Int) {
        
        self.allArticles.removeAll()
        
        for filter in filters {
            articleLoader.fetchArticles(page: page, category: filter) { [weak self] result in
                switch result {
                case .success(let response):
                        if let _ = self?.allArticles[filter] {
                            self?.allArticles[filter]?.append(contentsOf: response.articles)
                        } else {
                            self?.allArticles[filter] = response.articles
                        }
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
    
    func fetchNextPage(page: Int, filter: String) {
        articleLoader.fetchArticles(page: page, category: filter) { [weak self] result in
            switch result {
            case .success(let response):
                self?.allArticles[filter]?.append(contentsOf: response.articles)
            case .failure(let error):
                print("Error: \(error)")
            }
        }

    }
}

