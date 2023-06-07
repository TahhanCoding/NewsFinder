//
//  ArticleView.swift
//  NewsFinder
//
//  Created by Ahmed Shaban on 06/06/2023.
//

import SwiftUI
import SafariServices

struct ArticleView: View {
    let article: Article
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            RemoteImage(url: URL(string: article.urlToImage ?? "")) {
                LoadingView()
            }
            .frame(height: 200)
            
            Text(article.title)
                .font(.title)
                .bold()
            Group {
                Text("Author: \(article.author ?? "NA")")
                Text("Source: \(article.source.name ?? "NA")")
                Text("Published at: \(formatDate(article.publishedAt))")
            }
            .font(.subheadline)
            
            Text(article.description ?? "NA")
                .font(.body)
            }
        .padding()

        
        Button(action: {
            openURL()
        }) {
            Text("Read Article")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
        }
        .padding(.top, 20)

    }
    
    
    private func formatDate(_ dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")

        if let date = formatter.date(from: dateString) {
            formatter.dateFormat = "dd/MM/yyyy"
            return formatter.string(from: date)
        } else {
            return "Invalid date format"
        }
    }
    private func openURL() {
        if let url = URL(string: article.url) {
            let safariViewController = SFSafariViewController(url: url)
            
            // Task requires supporting iOS13
            UIApplication.shared.windows.first?.rootViewController?.present(safariViewController, animated: true, completion: nil)
        }
    }
}


