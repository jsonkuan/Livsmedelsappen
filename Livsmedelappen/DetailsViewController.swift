//
//  DetailsViewController.swift
//  Livsmedelappen
//
//  Created by Jason Kuan on 2017-02-20.
//  Copyright © 2017 jsonkuan. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var carbohydrateLabel: UILabel!
    @IBOutlet weak var healthynessLabel: UILabel!
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var sugarLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!

    
    let manager = DataManager.sharedInstance
    var foodProduct: FoodProduct!
    var shouldHideButton: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isEnabled = true
        saveButton.setTitle("Spara som favorit", for: .normal)
        
        if shouldHideButton {
            saveButton.isHidden = true
            titleImage.image = #imageLiteral(resourceName: "Favorites")
        } else {
            titleImage.image = #imageLiteral(resourceName: "Logo")
        }
        let url = "http://www.matapi.se/foodstuff/\(foodProduct.number)"
        self.manager.loadNutritionFromUrl(url: url)
        configureLabels()
    }
    
    func configureLabels() {
        if let cal = foodProduct.calories,
            let protein = foodProduct.protein,
            let sugar = foodProduct.sugar,
            let fat = foodProduct.fat {
            carbohydrateLabel?.text = "Kolhydrater: \(cal)g"
            proteinLabel?.text = "Protein: \(protein)g"
            sugarLabel?.text =  "Socker: \(sugar)g"
            fatLabel?.text =  "Fett: \(fat)g"
        }
        titleLabel?.text =  "\(foodProduct.name)"
        healthynessLabel?.text = "Nyttighetsvärde: \(calculateNutritionalRating())/10"
    }
    
    func calculateNutritionalRating() -> Double {
        if let protein = foodProduct.protein,
            let carbs = foodProduct.carbohydrates,
            let sugar = foodProduct.sugar,
            let fat = foodProduct.fat {
            let good = protein + carbs
            let bad = sugar + fat
            return round(good / bad)
        }
        return 0
    }
    
    // MARK: - Camera 
    
    @IBAction func takePhoto(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            picker.sourceType = .savedPhotosAlbum
        } else {
            fatalError("No source type.")
        }
        present(picker, animated: true, completion: nil)
    }
     
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        
        //UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        if let data = UIImagePNGRepresentation(image) {
            do {
                let url = URL(fileURLWithPath: imagePath)
                try data.write(to: url)
                NSLog("Done writing image data to file \(imagePath)")
            } catch let error{
                NSLog("Failed to save image data: \(error)")
            }
        }
        imageView.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    var imagePath: String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        if let documentsDirectory = paths.first {
            return documentsDirectory.appending(("/cached.png"))
        } else {
            fatalError("No documents directory")
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Favorites
    
    @IBAction func saveToFavorites(_ sender: Any) {
        manager.favorites.append(foodProduct)
        manager.saveFavorites()
        
        saveButton.isEnabled = false
        saveButton.setTitle("Sparat!", for: .disabled)
    }
    
  // MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//     // Get the new view controller using segue.destinationViewController.
//     // Pass the selected object to the new view controller.
//     }

}
