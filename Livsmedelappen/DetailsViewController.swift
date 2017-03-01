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
    
    var manager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carbohydrateLabel?.text = "Kolhydrater: \(manager.data[0].number)g"
        proteinLabel?.text = "Protein: \(manager.data[0].number)g"
        sugarLabel?.text =  "Socker: \(manager.data[0].number)g"
        fatLabel?.text =  "Fett: \(manager.data[0].number)g"
        titleLabel?.text =  "\(manager.data[0].name)"
    }
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
    
}
