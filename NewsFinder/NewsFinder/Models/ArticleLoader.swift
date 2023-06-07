//
//  ArticleLoader.swift
//  NewsFinder
//
//  Created by Ahmed Shaban on 04/06/2023.
//

import Alamofire

class ArticleLoader {
    
    private let country = "us"
    private let apiKey = "662d33b376a0425ba5f0446808bcafb9"
    private let baseURL = "https://newsapi.org/v2/top-headlines"
    
    func fetchArticles(page: Int, category: String, completion: @escaping (Result<Response, Error>) -> Void) {
        
        let api = "\(baseURL)?apiKey=\(apiKey)&country=\(country)&page=\(page)&category=\(category)"
        
        AF.request(api).responseDecodable(of: Response.self) { response in
            switch response.result {
            case .success(let articlesResponse):
                completion(.success(articlesResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
