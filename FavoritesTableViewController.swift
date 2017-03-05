//
//  FavoritesTableViewController.swift
//  Livsmedelappen
//
//  Created by Jason Kuan on 2017-03-01.
//  Copyright © 2017 jsonkuan. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController {

    let manager = DataManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.loadFavorites()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.favorites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
       
        cell.foodProduct = manager.favorites[indexPath.row]
        cell.nameLabel?.text = cell.foodProduct?.name
        if let calories =  cell.foodProduct?.calories {
            cell.energyValueLabel?.text = "\(calories) kCal"
        }
        return cell
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetailsViewController" {
            let detailsViewController = segue.destination as! DetailsViewController
            if let cell = sender as? MyTableViewCell {
                detailsViewController.titleLabel?.text = cell.foodProduct?.name
                detailsViewController.foodProduct = cell.foodProduct
            }
            detailsViewController.shouldHideButton = true
        }
    }

}
