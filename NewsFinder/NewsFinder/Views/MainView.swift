//
//  MainView.swift
//  NewsFinder
//
//  Created by Ahmed Shaban on 04/06/2023.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject private var viewModel = ArticleViewModel()

    private let filters = ["All", "Business", "Entertainment", "General", "Health", "Science", "Sports", "Technology"]
    
    @State private var filtersPages: [String: Int] = ["All": 1, "Business": 1, "Entertainment": 1, "General": 1, "Health": 1, "Science": 1, "Sports": 1, "Technology": 1]
    
    @State private var articles: [Article] = []
    @State private var scrolledToEnd = false
    @State private var filter = "All"
    
    var body: some View {
        NavigationView {
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
                        ForEach(filters, id:\.self) { filter in
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
                    
                    ZStack {
                        NavigationLink(destination: ArticleView(article: article)) { EmptyView() }.opacity(0.0)
                        
                        HStack() {
                            // This is like AsyncImage() Introduced in iOS15, The Task requires iOS13 and above.
                            RemoteImage(url: URL(string: article.urlToImage ?? "")) {
                                LoadingView()
                            }
                            .frame(width: 100, height: 100)
                            
                            VStack(alignment: .leading) {
                                Text(article.title)
                                    .font(.headline)
                                    .padding(.vertical, 4)
                                    .onAppear {
                                        if article.title == articles.last?.title {
                                            scrolledToEnd = true
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
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                    }
                }
            }
        }
        .onAppear {
            loadArticles()
        }
        .onchange(value: filter) { _ in
            changeFilter()
        }
        .onchange(value: scrolledToEnd) { _ in
            if scrolledToEnd {
                if var pages = filtersPages[filter] {
                    pages += 1
                    filtersPages[filter] = pages
                }
                loadNextPage()
                scrolledToEnd.toggle()
            }
        }
    }
    
    
    // MARK: - MainView Methods
    private func changeFilter() {
        if filter == "All" {
            self.articles = Array(viewModel.allArticles.values.flatMap { $0 })
        } else if let articles = viewModel.allArticles[filter] {
            self.articles = articles
        }
    }
    private func loadArticles() {
        viewModel.fetchArticles(page: 1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.articles = Array(viewModel.allArticles.values.flatMap { $0 })
        }
    }
    private func loadNextPage() {
        if let pageToLoad = filtersPages[filter] {
            if filter == "All" {
                viewModel.fetchArticles(page: pageToLoad)
                
                let allArticles = Array(viewModel.allArticles.values.flatMap { $0 })
                let totalCount = allArticles.count
                let oldCount = self.articles.count
                
                for article in allArticles[oldCount..<totalCount] {
                    self.articles.append(article)
                }
            }
            else {
                viewModel.fetchNextPage(page: pageToLoad, filter: filter)
                
                if let articles = viewModel.allArticles[filter] {
                    let totalCount = articles.count
                    let oldCount = self.articles.count
                    
                    for article in articles[oldCount..<totalCount] {
                        self.articles.append(article)
                    }
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





