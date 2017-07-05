//
//  TableViewController.swift
//  On The Map
//
//  Created by Pinak Jalan on 7/4/17.
//  Copyright © 2017 Pinak Jalan. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    
    
    var locations:[StudentLocation]?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        locations = ParseClient.sharedInstance().studentInfo
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (locations?.count)!
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let location = locations?[indexPath.row]
        //print(location.firstName)
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableviewCell", for: indexPath)
        cell.textLabel?.text = (location?.firstName)! + " " + (location?.lastName)!
        cell.detailTextLabel?.text = (location?.mediaURL)!


        // Configure the cell...

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let app = UIApplication.shared
        app.openURL(URL(string: (locations?[indexPath.row].mediaURL!)!)!)
    }

}


