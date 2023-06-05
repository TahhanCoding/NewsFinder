//
//  ImageLoader.swift
//  NewsFinder
//
//  Created by Ahmed Shaban on 05/06/2023.
//

import Alamofire

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let url: URL?
    
    init(url: URL?) {
        self.url = url
    }
    
    func load() {
        guard let url = url else { return }
        
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                if let loadedImage = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = loadedImage
                    }
                }
            case .failure(let error):
                print("Image loading failed with error: \(error)")
            }
        }
    }
}

