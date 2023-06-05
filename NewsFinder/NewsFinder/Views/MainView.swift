//
//  MainView.swift
//  NewsFinder
//
//  Created by Ahmed Shaban on 04/06/2023.
//

import SwiftUI

struct MainView: View {
    
    let filters = ["Filter 1", "Filter 2", "Filter 3", "Filter 4", "Filter 5"]
    
    @State private var articles: [Article] = []
    
    var body: some View {
        VStack {
            ZStack {
                Color.blue
                    .frame(height: 50)
                Text("News")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .padding()
            }

            // MARK: - Filters
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(filters, id: \.self) { filter in
                        Button(action: {
                            print("Tapped filter: \(filter)")
                        }) {
                            Text(filter)
                                .font(.footnote)
                                .padding()
                        }
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .frame(height: 40)
                        .cornerRadius(15)
                    }
                }
                .padding()
            }
            .frame(height: 50)
            
            // MARK: - List of Articles
            List(articles, id: \.id) { article in
                HStack() {
                    RemoteImage(url: URL(string: article.urlToImage ?? "")) {
                        ProgressView()
                    }
                    .frame(width: 100, height: 100)

                    VStack(alignment: .leading) {
                        Text(article.title)
                            .font(.headline)
                            .padding(.vertical, 4)

                        Text("Author: \(article.author ?? "NA")")
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        Text("Source: \(article.source.name ?? "NA")")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .onAppear {
            loadArticles()
        }
    }
    
    
    // MARK: - MainView Methods
    private func loadArticles() {
        NewsItemLoader.shared.fetchArticles(category: "business") { result in
            switch result {
            case .success(let Response):
                articles = Response.articles
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}





