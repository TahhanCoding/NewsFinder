//
//  NewsItemLoader.swift
//  NewsFinder
//
//  Created by Ahmed Shaban on 04/06/2023.
//

import Alamofire
import Foundation

class NewsItemLoader {
    
    static let shared = NewsItemLoader()
    
    private let apiKey = "f0d0a665bd2549859e4d44f0191e4f69"
    private let baseURL = "https://newsapi.org/v2/top-headlines"
    private var page = 1
    private var category = "business"
    private let country = "us"

    private var apiURL: String {
        return "\(baseURL)?apiKey=\(apiKey)&country=\(country)&page=\(page)&category=\(category)"
    }

    func fetchArticles(category: String, completion: @escaping (Result<Response, Error>) -> Void) {
        
        self.category = category
        
        AF.request(apiURL).responseDecodable(of: Response.self) { response in
            switch response.result {
            case .success(let articlesResponse):
                completion(.success(articlesResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    
    
    
    
}
