//
//  SearchListTableViewController.swift
//  Livsmedelappen
//
//  Created by Jason Kuan on 2017-02-20.
//  Copyright © 2017 jsonkuan. All rights reserved.
//

import UIKit

class SearchListTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var sampleData = ["one", "two", "three", "four", "twohundred"]
    var searchController: UISearchController!
    var searchResult: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
//        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (shouldUseSearchResult ? searchResult : sampleData).count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! MyTableViewCell
        if shouldUseSearchResult {
            cell.textLabel?.text = searchResult[indexPath.row]
            cell.foodProduct = searchResult[indexPath.row]
        } else {
            cell.textLabel?.text = sampleData[indexPath.row]
            cell.foodProduct = sampleData[indexPath.row]
        }
        cell.imageView?.image = #imageLiteral(resourceName: "logo")
        
        return cell
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */

        // MARK: - UISearchResultsUpdating protocol methods
    
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text?.lowercased() {
            searchResult = sampleData.filter { $0.contains(text) }
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
        if let cell = sender as? MyTableViewCell {
            segue.destination.title = cell.foodProduct
        }
     }
    
}
