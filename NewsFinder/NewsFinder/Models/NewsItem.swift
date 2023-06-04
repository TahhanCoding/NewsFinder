//
//  NewsItem.swift
//  NewsFinder
//
//  Created by Ahmed Shaban on 04/06/2023.
//

import Foundation

struct NewsItem: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let author: String
    let source: String
}
