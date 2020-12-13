//
//  ViewController.swift
//  RecipeFinder
//
//  Created by Andy Kotz on 12/12/20.
//

import UIKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    /*
     set up variables and dictionary of recipes
     */
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var findRecipeButtonOutlet: UIButton!
    
    var lst = [String]()
    var recipeDict: [String: (Set<String>, String, [Int])] = [:]
    var userSet = Set<String>()
    var bestURL: String = ""
    
    @IBOutlet weak var userInputList: UITextField!
    
    
    func makeDict() {
        let K = RecipeIngredients()
        recipeDict = K.makeDict()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        findRecipeButtonOutlet.layer.borderWidth = 1.5
        findRecipeButtonOutlet.layer.borderColor = UIColor.white.cgColor
        findRecipeButtonOutlet.layer.cornerRadius = findRecipeButtonOutlet.bounds.width / 15

    }
    
    /*
     Actions to occur when user has input values and is ready to see list of recipes
     */
    
    @IBAction func goButtonPressed(_ sender: UIButton) {
        let userString = userInputList.text
        let userArr = userString?.components(separatedBy: ", ")
        for ingrediant in userArr! {
            userSet.insert(ingrediant)
        }
        makeDict()
        
        findBestURL()
        // set up table view and reload data in case table view is loaded before data was added
        DispatchQueue.main.async {
            self.tableView.reloadData()
            let indexPath = IndexPath(row: self.recipeDict.count - 1,section: 0 )
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
        
    }
    
    /*
         find the url with the most matches, and any websites that have the same
         amount of matches and add them to the list of options
         */
    func findBestURL(){
        var max = 0
        for (_, ing) in recipeDict {
            let count = userSet.intersection(ing.0).count
            if count > max {
                max = count
            }
        }
        lst = [String]()
        var i = 0
        var total = 5
        for (url, ing) in recipeDict {
            let count = userSet.intersection(ing.0).count
            if count == max {
                lst.append(url)
                total -= 1
                recipeDict[url]?.2 = [i]
                i += 1
            }
        }
    }

    //Mark: tableview delegate methods

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



