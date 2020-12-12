////
////  ArticleFetcher.swift
////  RecipeFinder
////
////  Created by Andy Kotz on 12/12/20.
////
//import UIKit
//import SwiftUI
//import SwiftLinkPreview
//
//class ArticleFetcher: ObservableObject {
//    @Published var article: Response
//    
//    init(article: Response) {
//        self.article = article
//        getArticleWithURL(article.id)
//    }
//    
//    func getArticleWithURL(_ url: String) {
//        let linkPreview = SwiftLinkPreview()
//        linkPreview.preview(url, onSuccess: { (response) in
//            self.article.title = response.title ?? "Article Title"
//            self.article.link = response.canonicalUrl
//            if let imageURL = response.image {
//                guard let url = URL(string: imageURL) else {return}
//                URLSession.shared.dataTask(with: url) {(data, response, error) in
//                    DispatchQueue.main.async {
//                        self.article.imageData = data
//                    }
//                }.resume()
//            }
//        }) { (error) in
//            print(error)
//        }
//    }
//}
