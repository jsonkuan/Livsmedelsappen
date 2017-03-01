//
//  FoodProduct.swift
//  Livsmedelappen
//
//  Created by Jason Kuan on 2017-02-27.
//  Copyright © 2017 jsonkuan. All rights reserved.
//

import Foundation

class FoodProduct {
    let name: String
    let number: Int
    let calories: Int
//    , protein, fat, carbohydrates, sugar: Int
//    enum Nutrition: String {
//        case calories, protein, fat, carbohydrates, sugar
//    }
    
    init(name: String, number: Int, calories: Int) {
        self.name = name
        self.number = number
        self.calories = calories
        
    }
    
    init(json: [String: Any]) {
        guard let name = json["name"] as? String else {
            fatalError("Doesnt work")
        }
        
        guard let number = json["number"] as? Int else {
            fatalError("Unable to parse numbers")
        }
        
        //        guard let container = json["number"] as? [String: Any],
        //            let nutrientValue = container["nutrientValues"] as? [String:Any],
        //            let calories = nutrientValue["energyKcal"] as? Int else {
        //                fatalError("Unable to parse calories")
        //        }
        self.name = name
        self.number = number
        self.calories = 404
        
//        self.protein = protein
//        self.fat = fat
//        self.carbohydrates = carbohydrates
//        self.sugar = sugar
    }
}

