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
    @IBOutlet weak var compareButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var sugarLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    
    let manager = DataManager.sharedInstance
    var foodProduct: FoodProduct!
    var shouldHideButton: Bool = true
    var shouldHideCompare: Bool = true
    var imageID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isEnabled = true
        saveButton.setTitle("Spara som favorit", for: .normal)
        compareButton.isEnabled = true
        compareButton.setTitle("Gemföra", for: .normal)
        
        if foodProduct.foodImage != nil {
            imageView.image = foodProduct.foodImage
        }
        
        if shouldHideButton {
            saveButton.isHidden = true
            navigationItem.rightBarButtonItem?.tintColor = UIColor.LivsmedelGreen()
            titleImage.image = #imageLiteral(resourceName: "Favorites")
        } else {
            titleImage.image = #imageLiteral(resourceName: "Logo")
        }
        
        if shouldHideCompare {
            compareButton.isHidden = true
        }
        
        DispatchQueue.main.async {
            let url = "http://www.matapi.se/foodstuff/\(self.foodProduct.number)"
            self.manager.loadNutritionFromUrl(url: url)
            self.configureLabels()
        }
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
        foodProduct.foodImage = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    var imagePath: String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        if let documentsDirectory = paths.first {
            return documentsDirectory.appending(("/cached)\(imageID+=1).png"))
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
    
    @IBAction func compareItem(_ sender: UIButton) {
        if manager.compare.count <= 1 {
            manager.compare.append(foodProduct)
        } else {
            manager.compare.removeFirst()
            manager.compare.append(foodProduct)
        }
        compareButton.isEnabled = false
        compareButton.setTitle("Lagt till i diagram!", for: .normal)
    }
}
