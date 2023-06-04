//
//  Response.swift
//  NewsFinder
//
//  Created by Ahmed Shaban on 04/06/2023.
//

import Foundation

struct Response: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable {
    let id = UUID()
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
    
    enum CodingKeys: String, CodingKey {
        case source, author, title, description, url, urlToImage, publishedAt, content
    }

}

struct Source: Codable {
    let id: String?
    let name: String?
}
