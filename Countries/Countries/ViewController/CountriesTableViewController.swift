//
//  CountriesTableViewController.swift
//  Countries
//
//  Created by Juhi Gautam on 05/01/19.
//  Copyright © 2019 Juhi Gautam. All rights reserved.
//

import UIKit

class CountriesTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var filteredTableData : [CountryInfo]?
    var resultSearchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.definesPresentationContext = true
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.placeholder = "Search Country"
            controller.searchBar.sizeToFit()
            
            self.tableView.tableHeaderView = controller.searchBar
            self.tableView.tableFooterView = UIView()
            return controller
        })()
        
        // Reload the table
        self.tableView.reloadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (self.resultSearchController.isActive || filteredTableData != nil) {
            return self.filteredTableData!.count
        }
        else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // 3
        if (self.resultSearchController.isActive || filteredTableData != nil) {
            let countryInfo = filteredTableData![indexPath.row]
            cell.textLabel?.text = countryInfo.countryName
            cell.imageView?.dowloadFromServer(link: countryInfo.flagUrl!)
            return cell
        }
        else {
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.resultSearchController.searchBar.resignFirstResponder()
        self.performSegue(withIdentifier: "SendDataSegue", sender: self)
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "SendDataSegue" {
            let indexPaths=self.tableView!.indexPathsForSelectedRows!
            let indexPath = indexPaths[0] as NSIndexPath
            let vc = segue.destination as! CountryDetailViewController
            if (self.resultSearchController.isActive) {
                let countryInfo = filteredTableData![indexPath.row]
                vc.countryDetailInfo = countryInfo
            }
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let BaseUrl = "https://restcountries.eu/rest/v2/name/"
        let searchName : String = searchController.searchBar.text!
        let urlStr = "\(BaseUrl)\(searchName)"
        let url = URL(string: urlStr)!
        ServiceHandler.sharedServiceHandler.fetchCountries(url: url){ finish in
            if (UserDefaults.standard.value(forKey: "countryInfoList") != nil){
                self.filteredTableData?.removeAll(keepingCapacity: false)
                let userDefault = UserDefaults.standard
                let decoded  = userDefault.object(forKey: "countryInfoList") as! Data
                self.filteredTableData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? [CountryInfo]
                self.tableView.reloadData()
            }
        }
    }

}
