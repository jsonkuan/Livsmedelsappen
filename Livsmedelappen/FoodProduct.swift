//
//  FoodProduct.swift
//  Livsmedelappen
//
//  Created by Jason Kuan on 2017-02-27.
//  Copyright © 2017 jsonkuan. All rights reserved.
//

import Foundation

struct FoodProduct {
    let name: String
    let number: Int
    let calories: Int
    
    enum Nutrition: String {
        case calories, protein, fat, carbohydrates
    }
    
    init(name: String, number: Int) {
        self.name = name
        self.number = number
        calories = 0
    }
    
    init(json: [String: Any]) {
        guard let name = json["name"] as? String else {
            fatalError("Doesnt work")
        }
        
        guard let number = json["number"] as? Int else {
            fatalError("Unable to parse numbers")
        }
        
//        guard let cal = json["carbohydrates"] as? Int else {
//                fatalError("Unable to parse calories")
//        }
//        
        //        guard let Nutrition.calories = json["number"]
        
        self.name = name
        self.number = number
        self.calories = 0
    }
}

