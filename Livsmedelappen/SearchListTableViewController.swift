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
    let manager = DataManager()
    
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
        return (shouldUseSearchResult ? searchResult : manager.sampleData).count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! MyTableViewCell
        if shouldUseSearchResult {
            cell.nameLabel?.text = searchResult[indexPath.row].name
            cell.name = searchResult[indexPath.row].name
            
            cell.energyValueLabel?.text = "930 kj"
            cell.energyValue = 230
            //cell.energyValue = nutritionSearchResult[indexPath.row].calories
        } else {
            cell.nameLabel?.text = manager.sampleData[indexPath.row].name
            cell.name = manager.sampleData[indexPath.row].name
            
            cell.energyValueLabel?.text = "300 kj"
            cell.energyValue = 300
        }
        return cell
    }
    
    // MARK: - UISearchResultsUpdating protocol methods
    
    func updateSearchResults(for searchController: UISearchController) {
     
        if let query = searchController.searchBar.text?.lowercased() {
            let url = "http://www.matapi.se/foodstuff?query=\(query)"
            manager.loadDataFromUrl(url: url)
            searchResult = manager.data.filter { $0.name.contains(query) }
        } else {
            searchResult = manager.sampleData
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
        if let cell = sender as? MyTableViewCell {
            segue.destination.title = cell.name
        }
    }
    
}

