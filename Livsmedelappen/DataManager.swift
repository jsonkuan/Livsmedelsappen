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
    
    var data: [FoodProduct] = []
    var sampleData: [FoodProduct] = [FoodProduct.init(name: "Ex: Blomkål", number: 1),
                                     FoodProduct.init(name: "Ex: Havre", number: 2),
                                     FoodProduct.init(name: "Ex: Ostkaka", number: 3)]
    
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
                            NSLog("Failed to cast from json")
                        }
                    } catch let parseError {
                        NSLog("Failed to parse json: \(parseError)")
                    }
                } else {
                    NSLog("No data received")
                }
            }
            task.resume()
        } else {
            NSLog("Failed to create url.")
        }
    }
}
