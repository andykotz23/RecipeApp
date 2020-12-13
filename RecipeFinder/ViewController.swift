//
//  ViewController.swift
//  RecipeFinder
//
//  Created by Andy Kotz on 12/12/20.
//

import UIKit
//import SwiftLinkPreview

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var lst = [String]()
    
    
    var recipeDict: [String: (Set<String>, String, [Int])] = [:]
    var userSet = Set<String>()
    var bestURL: String = ""
    
    @IBOutlet weak var userInputList: UITextField!
    let recipe1Ing: Set = ["flour", "salt", "butter", "cream cheese", "sour cream", "brown sugar", "walnuts","raisins","cinnamon", "sugar"]
    let challahIng: Set = ["yeast", "flour", "sugar", "salt", "eggs", "oil"]
    
    func makeDict() {
        recipeDict = [
            "https://sallysbakingaddiction.com/how-to-make-rugelach-cookies/": (recipe1Ing, "Rugelach", [1]),
            "https://www.thekitchn.com/how-to-make-challah-bread-181004": (challahIng, "Challah", [1])
        ]
    }
    //let url = "https://sallysbakingaddiction.com/how-to-make-rugelach-cookies/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        //view = tableView //maybe not
        //tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "BasicCell")
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
        print("We have chosen a \(recipeDict[bestURL]?.1 ?? "Nothing") for you, would you like to go to the recipe? Click next if yes, re-type in ingrediants to find another")
        //tableView.reloadData()
        DispatchQueue.main.async {
            self.tableView.reloadData()
            let indexPath = IndexPath(row: self.recipeDict.count - 1,section: 0 )
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
        
    }
    
    @IBAction func goToWeb(_ sender: UIButton) {
        if let url = URL(string: bestURL) {
            UIApplication.shared.open(url)
        }
    }
    

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
        lst = [String]()
        var i = 0
        for (url, ing) in recipeDict {
            let count = userSet.intersection(ing.0).count
            if count > max - 2 && count < max + 2 {
                lst.append(url)
                
                recipeDict[url]?.2 = [i]
//                recipeDict[url] = (set!,tuple?.1!,i)
                i += 1
            }
        }
        return lst.randomElement()!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4 //change to however many recipes it makes sense to show the user
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < lst.count {
            let message = lst[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) //check string origin
            cell.textLabel?.text = recipeDict[message]?.1
        //cell.label.text = recipeDict[message]?.1
        
        return cell
        }
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for (i,j) in recipeDict {
            if j.2 == [indexPath.row] {
                print(indexPath.row,i)
                if let url = URL(string: i) {
                    UIApplication.shared.open(url)
                }
            }
        }
    }
}


