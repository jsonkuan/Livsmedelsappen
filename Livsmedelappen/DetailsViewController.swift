//
//  DetailsViewController.swift
//  Livsmedelappen
//
//  Created by Jason Kuan on 2017-02-20.
//  Copyright © 2017 jsonkuan. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var carbohydrateLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var sugarLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var healthynessLabel: UILabel!
    
    let manager = DataManager.sharedInstance
    var foodProduct: FoodProduct!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "http://www.matapi.se/foodstuff/\(foodProduct.number)"
        manager.loadNutritionFromUrl(url: url)
        
        configureLabels()
    }
    
    func configureLabels() {
        if let cal = foodProduct.calories,
            let protein = foodProduct.protein,
            let salt = foodProduct.salt,
            let fat = foodProduct.fat {
            carbohydrateLabel?.text = "Kolhydrater: \(cal)g"
            proteinLabel?.text = "Protein: \(protein)g"
            sugarLabel?.text =  "Salt: \(salt)g" //REFACTOR LABEL
            fatLabel?.text =  "Fett: \(fat)g"
        }
        titleLabel?.text =  "\(foodProduct.name)"
        healthynessLabel?.text = "Nyttighetsvärde: \(foodProduct.number)/10"
    }
    
    @IBAction func takePhoto(_ sender: Any) {
    }
    
    @IBAction func saveToFavorites(_ sender: Any) {
        manager.favorites.append(manager.data[0])
        
        //        var archiveArray: [Data]?
        //        let favoriteItem = NSKeyedArchiver.archivedData(withRootObject: manager.favorites)
        //        archiveArray?.append(favoriteItem)
        //
        //        let defaults = UserDefaults.standard
        //        defaults.set(favoriteItem, forKey: "favoritesList")
        //        defaults.synchronize()
        //
        //        NSMutableArray *archiveArray = [NSMutableArray arrayWithCapacity:mutableDataArray.count];
        //        for (BC_Person *personObject in mutableDataArray) {
        //            NSData *personEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:personObject];
        //            [archiveArray addObject:personEncodedObject];
        //        }
        //
        //        NSUserDefaults *userData = [NSUserDefaults standardUserDefaults];
        //        [userData setObject:archiveArray forKey:@"personDataArray"];
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //     // Get the new view controller using segue.destinationViewController.
    //     // Pass the selected object to the new view controller.
    //     }
    
}
