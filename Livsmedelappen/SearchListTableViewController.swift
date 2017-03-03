//
//  SearchListTableViewController.swift
//  Livsmedelappen
//
//  Created by Jason Kuan on 2017-02-20.
//  Copyright © 2017 jsonkuan. All rights reserved.
//

import UIKit

class SearchListTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var searchController: UISearchController!
    var searchResult: [FoodProduct] = []
    let manager = DataManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Sök Livsmedel"
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (shouldUseSearchResult ? searchResult : []).count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! MyTableViewCell
        
        if shouldUseSearchResult {
            cell.foodProduct = searchResult[indexPath.row]
            let url = "http://www.matapi.se/foodstuff/\(cell.foodProduct!.number)"
            manager.loadNutritionFromUrl(url: url)
            
            cell.nameLabel?.text = searchResult[indexPath.row].name
            if let calories = searchResult[indexPath.row].calories {
                cell.energyValueLabel?.text = "\(calories) kCal"
            }
        } else {
            cell.nameLabel?.text = ""
            cell.energyValueLabel?.text = "" 
        }
        return cell
    }
    
    // MARK: - UISearchResultsUpdating protocol methods
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if let query = searchController.searchBar.text?.lowercased() {
            let url = "http://www.matapi.se/foodstuff?query=\(query)"
            manager.loadDataFromUrl(url: url)
            searchResult = manager.data.filter { $0.name.contains(query)}
        } else {
            searchResult = []
        }
        tableView.reloadData()
    }
    
    var shouldUseSearchResult: Bool {
        if let text = searchController.searchBar.text {
            if text.isEmpty {
                return false
            }
        }
        return searchController.isActive
    }
    
    // MARK: - Navigation
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
            if segue.identifier == "pushToDetailsView" {
                let detailsViewController = segue.destination as! DetailsViewController
                if let cell = sender as? MyTableViewCell {
                    detailsViewController.titleLabel?.text = cell.foodProduct?.name
//                    detailsViewController.fatLabel?.text = "Fat: \(cell.foodProduct?.fat)"
                    detailsViewController.foodProduct = cell.foodProduct
                }
            }
        }
}

