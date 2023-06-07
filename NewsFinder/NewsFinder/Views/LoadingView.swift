//
//  LoadingView.swift
//  NewsFinder
//
//  Created by Ahmed Shaban on 07/06/2023.
//

import SwiftUI

struct LoadingView: View {
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
            if #available(iOS 14.0, *) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2)
                    .padding()
                    .onAppear {
                        self.isAnimating = true
                    }
                    .onDisappear {
                        self.isAnimating = false
                    }
                    .animation(.default)
            } else {
                ActivityIndicator(isAnimating: $isAnimating, style: .large)
                    .frame(width: 50, height: 50)
            }
        }
    }
}

struct ActivityIndicator: UIViewRepresentable {
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
