//
//  FoodProduct.swift
//  Livsmedelappen
//
//  Created by Jason Kuan on 2017-02-27.
//  Copyright © 2017 jsonkuan. All rights reserved.
//

import Foundation

class FoodProduct : NSObject, NSCoding {
    
    let name: String
    let number: Int
    var calories: Double?
    var protein: Double?
    var carbohydrates: Double?
    var fat: Double?
    var sugar: Double?
    
    init(json: [String: Any]) {
        guard let name = json["name"] as? String else {
            fatalError("Doesnt work")
        }
        
        guard let number = json["number"] as? Int else {
            fatalError("Unable to parse numbers")
        }
        self.name = name
        self.number = number
    }
    
    init(name: String, number: Int) {
        self.name = name
        self.number = number 
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        self.number = aDecoder.decodeInteger(forKey: "number")
        
//        self.calories = aDecoder.decodeDouble(forKey: "calories")
//        self.protein = aDecoder.decodeDouble(forKey: "protein")
//        self.carbohydrates = aDecoder.decodeDouble(forKey: "carbohydrates")
//        self.fat = aDecoder.decodeDouble(forKey: "fat")
//        self.sugar = aDecoder.decodeDouble(forKey: "sugar")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(number, forKey: "number")
        aCoder.encode(calories, forKey: "calories")
        aCoder.encode(protein, forKey: "protein")
        aCoder.encode(carbohydrates, forKey: "carbohydrates")
        aCoder.encode(fat, forKey: "fat")
        aCoder.encode(sugar, forKey: "sugar")
    }
    
    override var description: String {
        return "Name: \(self.name), Number:\(self.number)"
    }
    
    
}

