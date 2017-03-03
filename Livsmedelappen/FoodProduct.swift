//
//  FoodProduct.swift
//  Livsmedelappen
//
//  Created by Jason Kuan on 2017-02-27.
//  Copyright © 2017 jsonkuan. All rights reserved.
//

import Foundation

class FoodProduct : CustomStringConvertible {
    
    let name: String
    let number: Int
    var calories: Double?
    var protein: Double?
    var carbohydrates: Double?
    var fat: Double?
    var salt: Double?
    
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
     //    required init?(coder aDecoder: NSCoder) {
    //        aDecoder.decodeObject(forKey: "favoriteList")
    //    }
    //
    //    func encode(with aCoder: NSCoder) {
    //        aCoder.encode(name)
    //        aCoder.encode(number)
    //        aCoder.encode(calories)
    //    }
    
    var description: String {
        return "Name: \(self.name), Number:\(self.number)"
    }
    
    
}

