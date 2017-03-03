//
//  DataManager.swift
//  Livsmedelappen
//
//  Created by Jason Kuan on 2017-02-23.
//  Copyright © 2017 jsonkuan. All rights reserved.
//

import UIKit

enum SerializationError: Error {
    case missing(String)
    case invalid(String)
}

class DataManager {
    
    // Singleton
    static let sharedInstance: DataManager = {
        let instance = DataManager()
        //Setup code here...
        return instance
    }()
    
    var data: [FoodProduct] = []
    var favorites: [FoodProduct] = []
   
    func loadDataFromUrl(url: String) {
        if let safeUrlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: safeUrlString) {
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) {
                (maybeData: Data?, response: URLResponse?, error: Error?) in
                if let actualData = maybeData {
                    let jsonOptions = JSONSerialization.ReadingOptions()
                    do {
                        if let json = try JSONSerialization.jsonObject(with: actualData, options: jsonOptions) as? [[String:Any]] {
                            self.data = json.map(FoodProduct.init)
                        } else {
                            throw SerializationError.invalid("Failed to cast from json.")
                        }
                    } catch let parseError {
                        NSLog("Failed to parse json: \(parseError).")
                    }
                } else {
                    NSLog("No data received.")
                }
            }
            task.resume()
        } else {
            NSLog("Failed to create url.")
        }
    }
    
    func loadNutritionFromUrl(url: String) {
        if let safeUrlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: safeUrlString) {
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) {
                (maybeData: Data?, response: URLResponse?, error: Error?) in
                if let actualData = maybeData {
                    let jsonOptions = JSONSerialization.ReadingOptions()
                    do {
                        if let json = try JSONSerialization.jsonObject(with: actualData, options: jsonOptions) as? [String:Any] {
                            if let nutrientValue = json["nutrientValues"] as? [String: Double],
                                let number = json["number"] as? Int,
                                let calories = nutrientValue["energyKcal"],
                                let protein = nutrientValue["protein"],
                                let carbohydrates = nutrientValue["carbohydrates"],
                                let fat = nutrientValue["fat"],
                                let salt = nutrientValue["salt"],
                                let food = self.data.first(where: {number == $0.number }) {
                                
                                   DispatchQueue.main.async {
                                    food.calories = calories
                                    food.protein = protein
                                    food.carbohydrates = carbohydrates
                                    food.fat = fat
                                    food.salt = salt 
                                }
                            } else {
                                fatalError("Unable to parse nutritional data")
                            }
                        } else {
                            throw SerializationError.invalid("Failed to cast from json.")
                        }
                    } catch let parseError {
                        NSLog("Failed to parse json: \(parseError).")
                    }
                } else {
                    NSLog("No data received.")
                }
            }
            task.resume()
        } else {
            NSLog("Failed to create url.")
        }
    }

}
