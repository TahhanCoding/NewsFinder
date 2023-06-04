//
//  MainView.swift
//  NewsFinder
//
//  Created by Ahmed Shaban on 04/06/2023.
//

import SwiftUI

struct MainView: View {
    
    let filters = ["Filter 1", "Filter 2", "Filter 3", "Filter 4", "Filter 5"]
    
    @State var articles: [Article] = []
    
//    @State var images: [Image?] = []

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
            
            List(Array(articles.enumerated()), id: \.element.id) { (index, article) in
                HStack() {
                    
//                    if let image = images[index] {
//                        image
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(height: 100)
//                    } else {
//                        Rectangle()
//                            .foregroundColor(.gray)
//                            .frame(height: 100)
//                    }

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
            fetchArticles()
        }
    }
    
    
    private func fetchArticles() {
        NewsItemLoader.shared.fetchArticles(category: "business") { result in
            switch result {
            case .success(let Response):
                
                self.articles = Response.articles
                
                for article in articles {
                    self.loadImages(article.urlToImage)
                }

//                for article in articles {
                    // debugging function
//                    print("Hello: \(article.title)")
//                    break
//                }
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }

    }
    
    private func loadImages(_ urlString: String?) {
        guard let string = urlString else {
            return
        }
        guard let url = URL(string: string) else {
            return
        }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
               let uiImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    //TODO: add images to the view ..
                    
                    
                    
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
