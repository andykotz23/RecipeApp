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
    @IBOutlet weak var findRecipeButtonOutlet: UIButton!
    
    var lst = [String]()
    
    
    var recipeDict: [String: (Set<String>, String, [Int])] = [:]
    var userSet = Set<String>()
    var bestURL: String = ""
    
    @IBOutlet weak var userInputList: UITextField!
    
    
    func makeDict() {
        let K = RecipeIngredients()
        recipeDict = [
            K.rugelachURL: (K.recipe1Ing, "Rugelach", [1]),
            K.challahURL: (K.challahIng, "Challah", [1]),
            K.matzohSoupURL: (K.matzohIng, "Matzoh Ball Soup", [0]),
            K.kugelURL: (K.kugelING, "Noodle Kugel", [0]),
            K.shakshukaURL: (K.shakshukaIng, "Shakshuka", [0]),
            K.latkeURL: (K.latkeIng, "Potato Latke", [0]),
            K.brisketURL: (K.brisketIng, "Beef Brisket", [0]),
            K.flourlessCakeURL: (K.flourlessCakeIng, "Flourless Chocolate Cake", [0]),
            K.hamentashenURL: (K.hamentashenIng, "Hamentashen", [0]),
            K.israelSaladURL: (K.israelSalad, "Isaraeli Salad", [0]),
            K.reubenURL: (K.reubenIng, "Reuben", [0]),
            K.matzohBreiURL: (K.matzohBreiIng, "Matzoh Brei", [0]),
            //K.kugelURL: (K.kugelING, "Noodle Kugel", [0]),
            K.falafelURL: (K.falafelIng, "Falafel", [0]),
            K.sufganURL: (K.sufganIng, "Sufganiyot (Jelly Donut)", [0]),
            K.appleFritURl: (K.appleFritIng, "Apple Fritters", [0])
        ]
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        findRecipeButtonOutlet.layer.borderWidth = 1.5
        findRecipeButtonOutlet.layer.borderColor = UIColor.white.cgColor
        findRecipeButtonOutlet.layer.cornerRadius = findRecipeButtonOutlet.bounds.width / 15
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
        //print(userSet.intersection(recipe1Ing).count)
        makeDict()
        findBestURL()
//        print(bestURL)
//        print("We have chosen a \(recipeDict[bestURL]?.1 ?? "Nothing") for you, would you like to go to the recipe? Click next if yes, re-type in ingrediants to find another")
        //tableView.reloadData()
        DispatchQueue.main.async {
            self.tableView.reloadData()
            let indexPath = IndexPath(row: self.recipeDict.count - 1,section: 0 )
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
        
    }

    

    func findBestURL(){
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
        var total = 5
        for (url, ing) in recipeDict {
            let count = userSet.intersection(ing.0).count
            if count >= max {
                //- 2 && count <= max { //change to change how many show up
            //if count == max{
                lst.append(url)
                total -= 1
                recipeDict[url]?.2 = [i]
//                recipeDict[url] = (set!,tuple?.1!,i)
                i += 1
            }
        }
        //return lst.randomElement()!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15 //change to however many recipes it makes sense to show the user
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < lst.count {
            let message = lst[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) //check string origin
            cell.textLabel?.text = recipeDict[message]?.1
            //cell.textLabel?.backgroundColor = #colorLiteral(red: 0.9939097762, green: 0.7076752782, blue: 0.551975131, alpha: 1)
            cell.textLabel?.textColor = .black
            cell.textLabel?.font = UIFont(name: "Optima Regular", size: 25)
            cell.textLabel?.shadowColor = #colorLiteral(red: 0.8294614553, green: 0.4935253263, blue: 0.5416667461, alpha: 1)
            
            
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
extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        var i = 0
        if i == 0 {
            return UIColor.red
            i += 1
        } else {
            return UIColor.blue
//        red: .random(),
//        green: .random(),
//        blue: .random(),
//        alpha: 1.0
//        )
    }
}
}



