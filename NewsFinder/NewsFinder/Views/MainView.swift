//
//  MainView.swift
//  NewsFinder
//
//  Created by Ahmed Shaban on 04/06/2023.
//

import SwiftUI

struct MainView: View {
    let filters = ["Filter 1", "Filter 2", "Filter 3", "Filter 4", "Filter 5"]
    
    let newsItems = [
        NewsItem(image: "news1", title: "News 1", author: "Author 1", source: "Source 1"),
        NewsItem(image: "news2", title: "News 2", author: "Author 2", source: "Source 2"),
        NewsItem(image: "news3", title: "News 3", author: "Author 3", source: "Source 3"),
        NewsItem(image: "news4", title: "News 4", author: "Author 4", source: "Source 4"),
        NewsItem(image: "news5", title: "News 5", author: "Author 5", source: "Source 5")
    ]
    
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
            
            List(newsItems) { item in
                HStack() {
                    Image(item.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 100)
                    
                    VStack(alignment: .leading) {
                        Text(item.title)
                            .font(.headline)
                            .padding(.vertical, 4)
                        
                        Text("Author: \(item.author)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        Text("Source: \(item.source)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
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
