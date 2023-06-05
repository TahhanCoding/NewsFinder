//
//  MainView.swift
//  NewsFinder
//
//  Created by Ahmed Shaban on 04/06/2023.
//

import SwiftUI

struct MainView: View {

    let filters = ["All", "Business", "Entertainment", "General", "Health", "Science", "Sports", "Technology"]
    
    @State private var articles: [Article] = []
    @State private var filter = "All"
    
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
                            self.filter = filter
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
                    // This is like AsyncImage() Introduced in iOS15, The Task requires iOS13 and above.
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
            loadArticles(filter)
        }
        .onChange(of: filter) { _ in
            loadArticles(filter)
        }
        
    }
    
    
    // MARK: - MainView Methods
    private func loadArticles(_ filter: String) {
        var filtersToApply: [String] = []
        if filter == "All" {
            filtersToApply = Array(filters[1...])
        } else {
            filtersToApply.append(filter)
        }
        articles.removeAll()
        for filter in filtersToApply {
            NewsItemLoader.shared.fetchArticles(category: filter) { result in
                switch result {
                case .success(let Response):
                    articles.append(contentsOf: Response.articles)
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}





