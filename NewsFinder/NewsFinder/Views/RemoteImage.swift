//
//  RemoteImage.swift
//  NewsFinder
//
//  Created by Ahmed Shaban on 05/06/2023.
//

import SwiftUI

struct RemoteImage<Placeholder: View>: View {
    @ObservedObject private var imageLoader: ImageLoader
    private let placeholder: Placeholder
    
    init(url: URL?, @ViewBuilder placeholder: () -> Placeholder) {
        self.placeholder = placeholder()
        _imageLoader = ObservedObject(wrappedValue: ImageLoader(url: url))
    }
    
    var body: some View {
        Group {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                placeholder
            }
        }
        .onAppear(perform: imageLoader.load)
    }
}
