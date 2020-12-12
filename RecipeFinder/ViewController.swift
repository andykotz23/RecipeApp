//
//  ViewController.swift
//  RecipeFinder
//
//  Created by Andy Kotz on 12/12/20.
//

import UIKit
//import SwiftLinkPreview

class ViewController: UIViewController {
    var recipeDict: [String: (Set<String>, String)] = [:]
    var userSet = Set<String>()
    var bestURL: String = ""
    //private var result = Response()
    //private let placeholderImages = [CGImageSource(image: UIImage(named: "Placeholder")!)]
    //let slp = SwiftLinkPreview(session: URLSession = URLSession.shared, workQueue: DispatchQueue = SwiftLinkPreview.defaultWorkQueue, responseQueue: DispatchQueue = DispatchQueue.main, cache: Cache = DisabledCache.instance)
    //let slp = SwiftLinkPreview(session: URLSession = URLSession.shared, workQueue: DispatchQueue = SwiftLinkPreview.defaultWorkQueue, responseQueue: DispatchQueue = DispatchQueue.main, cache: Cache = DisabledCache.instance)
    
    @IBOutlet weak var userInputList: UITextField!
    let recipe1Ing: Set = ["flour", "salt", "butter", "cream cheese", "sour cream", "brown sugar", "walnuts","raisins","cinnamon", "sugar"]
    let challahIng: Set = ["yeast", "flour", "sugar", "salt", "eggs", "oil"]
    
    func makeDict() {
        recipeDict = [
            "https://sallysbakingaddiction.com/how-to-make-rugelach-cookies/": (recipe1Ing, "rugelach"),
            "https://www.thekitchn.com/how-to-make-challah-bread-181004": (challahIng, "Challah")
        ]
    }
    //let url = "https://sallysbakingaddiction.com/how-to-make-rugelach-cookies/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func goButtonPressed(_ sender: UIButton) {
        let userString = userInputList.text
        let userArr = userString?.components(separatedBy: ", ")
        //var userSet = Set<String>()
        for ingrediant in userArr! {
            userSet.insert(ingrediant)
        }
        print(userSet.intersection(recipe1Ing).count)
        makeDict()
        bestURL = findBestURL()
        print(bestURL)
        print("We have chosen a \(recipeDict[bestURL]?.1) for you, would you like to go to the recipe? Click next if yes, re-type in ingrediants to find another")
        
    }
    
    @IBAction func goToWeb(_ sender: UIButton) {
        if let url = URL(string: bestURL) {
            UIApplication.shared.open(url)
        }
    }
    
        //var articles = Response.sampleArticles()
        //var body: UIView {
//            Array(articles) { article in
//                ArticleRow(article: article)
//            }
//        }
//        let articleFetcher = ArticleFetcher(article: Response(link: bestURL))
//        //slp.preview(bestURL, onSuccess: { result in print("\(result)")},
//                    //onError: { error in print("\(error)")})
//        //var userSet: Set<String> = userArr as Set<String>
//    }
//    struct ArticleRow {
//        var articleFetcher: ArticleFetcher
//        init(article: Response) {
//            articleFetcher = ArticleFetcher(article: article)
//        }
//
//    }
    func findBestURL() -> String {
        //var best = ""
        var max = 0
        //var ingrediantsCount = 0
        for (url, ing) in recipeDict {
            let count = userSet.intersection(ing.0).count
            if count > max {
                max = count
                //best = url
                
            }
        }
        var lst = [String]()
        for (url, ing) in recipeDict {
            let count = userSet.intersection(ing.0).count
            if count > max - 2 && count < max + 5 {
                lst.append(url)
            }
        }
        return lst.randomElement()!
    }
    
    
    
//
//
//}
//
//struct Response {
//    let id: String?
//    var title: String = "Article Title"
//    var subtitle: String?
//    var link: String? = "Link to Article"
//    var imageLink: String?
//    var imageData: Data?
//
//    static func sampleArticles() -> [Response] {
//        var articles = [Response]()
//        var keys = [String]()
//        for thing in recipeDict.keys{
//            keys.append(thing)
//        }
//        for url in keys {
//            articles.append(Response(id: url))
//        }
//        return articles
//    }
////    let url: URL // URL
////    let finalUrl: URL // unshortened URL
////    let canonicalUrl: String // canonical URL
////    let title: String // title
////    let description: String // page description or relevant text
////    let images: [String] // array of URLs of the images
////    let image: String // main image
////    let icon: String // favicon
////    let video: String // video
////    let price: String // price
////}
//
//
}


