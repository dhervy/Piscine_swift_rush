//
//  ResponseTableViewController.swift
//  rush
//
//  Created by Duane HERVY on 1/13/19.
//  Copyright © 2019 Duane HERVY. All rights reserved.
//

import UIKit

class ResponseTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Replies"
    }
    
    var responses: [Response] = []

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("\n\n\n\n\n\nDEBUG TA MERE\n\n\n\(responses)\n")
        if responses.count > 0 {
            return responses.count
        }
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "responseTableViewCell", for: indexPath) as! ResponseTableViewCell
        
        //Configure the cell...
        
        if (responses.count == 0) {
            cell.response = Response(name: "Loading...", date:"", response:"", id:0, authorId: 0)
        }
        else {
            cell.response = responses[indexPath.row]
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

}
