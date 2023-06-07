//
//  RemoteImage.swift
//  NewsFinder
//
//  Created by Ahmed Shaban on 05/06/2023.
//

import SwiftUI

struct RemoteImage<Placeholder: View>: View {
    @ObservedObject private var imageViewModel: ImageViewModel
    private let placeholder: Placeholder
    
    init(url: URL?, @ViewBuilder placeholder: () -> Placeholder) {
        self.placeholder = placeholder()
        _imageViewModel = ObservedObject(wrappedValue: ImageViewModel(url: url))
    }
    
    var body: some View {
        Group {
            if let image = imageViewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                placeholder
            }
        }
        .onAppear(perform: imageViewModel.load)
    }
}
