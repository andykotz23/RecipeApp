//
//  ViewController.swift
//  RecipeFinder
//
//  Created by Andy Kotz on 12/12/20.
//

import UIKit
import SwiftLinkPreview

class ViewController: UIViewController {
    var recipeDict: [String: Set<String>] = [:]
    var userSet = Set<String>()
    //private var result = Response()
    //private let placeholderImages = [CGImageSource(image: UIImage(named: "Placeholder")!)]
    //let slp = SwiftLinkPreview(session: URLSession = URLSession.shared, workQueue: DispatchQueue = SwiftLinkPreview.defaultWorkQueue, responseQueue: DispatchQueue = DispatchQueue.main, cache: Cache = DisabledCache.instance)
    //let slp = SwiftLinkPreview(session: URLSession = URLSession.shared, workQueue: DispatchQueue = SwiftLinkPreview.defaultWorkQueue, responseQueue: DispatchQueue = DispatchQueue.main, cache: Cache = DisabledCache.instance)
    
    @IBOutlet weak var userInputList: UITextField!
    let recipe1Ing: Set = ["flour", "salt", "butter", "cream cheese", "sour cream", "brown sugar", "walnuts","raisins","cinnamon", "sugar"]
    let challahIng: Set = ["yeast", "flour", "sugar", "salt", "eggs", "oil"]
    func makeDict() {
        recipeDict = [
            "https://sallysbakingaddiction.com/how-to-make-rugelach-cookies/": recipe1Ing,
            "https://www.thekitchn.com/how-to-make-challah-bread-181004": challahIng
        ]
    }
    let url = "https://sallysbakingaddiction.com/how-to-make-rugelach-cookies/"
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
        let bestURL = findBestURL()
        print(bestURL)
        //slp.preview(bestURL, onSuccess: { result in print("\(result)")},
                    //onError: { error in print("\(error)")})
        //var userSet: Set<String> = userArr as Set<String>
    }
    
    func findBestURL() -> String {
        var best = ""
        var max = 0
        var ingrediantsCount = 0
        for (url, ing) in recipeDict {
            let count = userSet.intersection(ing).count
            if count > max {
                max = count
                best = url
                
            }
        }
        return url
    }
    
    
    


}

struct Response {
    let url: URL // URL
    let finalUrl: URL // unshortened URL
    let canonicalUrl: String // canonical URL
    let title: String // title
    let description: String // page description or relevant text
    let images: [String] // array of URLs of the images
    let image: String // main image
    let icon: String // favicon
    let video: String // video
    let price: String // price
}

