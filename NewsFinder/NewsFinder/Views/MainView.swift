//
//  MainView.swift
//  NewsFinder
//
//  Created by Ahmed Shaban on 04/06/2023.
//

import SwiftUI

struct MainView: View {

    let filters = ["All", "Business", "Entertainment", "General", "Health", "Science", "Sports", "Technology"]
    
    @State var filtersToApply: [String] = []
    @State private var articles: [Article] = []
    @State private var filter = "All"
    @State private var scrolledToEnd = false
    @State private var page = 1

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
                        .foregroundColor(self.filter == filter ? Color.white : Color.blue)
                        .background(self.filter == filter ? Color.blue : Color.white)
                        .frame(height: 40)
                        .cornerRadius(15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.blue, lineWidth: 1)
                        )
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
                            .onAppear {
                                if article.title == articles.last?.title {
                                    scrolledToEnd = true
                                    // Filter Debugger messages using "Hello"
                                    print("Hello: number of articles is \(articles.count)")
                                }
                            }

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
            changeFilter()
            loadArticles()
        }
        .onChange(of: filter) { _ in
            changeFilter()
            loadArticles()
        }
        .onChange(of: scrolledToEnd) { _ in
            if scrolledToEnd {
                page += 1
                loadArticles()
                scrolledToEnd.toggle()
            }
        }
    }
    
    
    // MARK: - MainView Methods
    private func loadArticles() {
        for filter in filtersToApply {
            NewsItemLoader.shared.fetchArticles(page: page, category: filter) { result in
                switch result {
                case .success(let Response):
                    articles.append(contentsOf: Response.articles)
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
    private func changeFilter() {
        // reset pages counter when changing filter
        page = 1
        
        if filter == "All" {
            filtersToApply = Array(filters[1...])
        } else {
            filtersToApply.removeAll()
            filtersToApply.append(filter)
        }
        
        articles.removeAll()
    }



}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}





