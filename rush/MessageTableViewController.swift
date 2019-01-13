//
//  MessageTableViewController.swift
//  rush
//
//  Created by Duane HERVY on 1/13/19.
//  Copyright © 2019 Duane HERVY. All rights reserved.
//

import UIKit

class MessageTableViewController: UITableViewController {

    var token: String?
    var id: Int? {
        didSet {
            getMessage()
        }
    }
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Messages"
    }
    
    func getMessage() {
        if let topicID = id {
            var urlComponent = URLComponents(string: "https://api.intra.42.fr/v2/topics/\(String(describing: topicID))/messages")!
            urlComponent.percentEncodedQuery = urlComponent.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
            if let url = urlComponent.url {
                var request = URLRequest(url:url)
                request.httpMethod = "GET"
                request.setValue("Bearer " + token!, forHTTPHeaderField: "Authorization")
                URLSession.shared.dataTask(with: request as URLRequest) {
                    (data, response, error) in
                    if let error = error {
                        print("API GET", error)
                    }
                    if let d = data {
                        do {
                            if let results: NSArray = try JSONSerialization .jsonObject(with: d, options: JSONSerialization.ReadingOptions.allowFragments  ) as? NSArray {

                                    if let test = results as? [NSDictionary] {
                                        for value in test {
                                            if let date = value["created_at"] as? String,
                                                let nameDic = value["author"] as? NSDictionary,
                                                let message = value["content"] as? String,
                                                let id = value["id"] as? Int,
                                                let name = nameDic["login"] as? String,
                                                let authorId = nameDic["id"] as? Int {
                                                if let replies = value["replies"] as? [NSDictionary] {
                                                    self.messages.append(Message(name: name, date: date, message: message, id: id, authorId: authorId, replies: replies))
                                                }
                                            }
                                        }
                                        DispatchQueue.main.async {
                                            self.tableView.reloadData()
                                        }
                                    }
                            }
                        } catch let err {
                            print("parse Error \(err)")
                        }
                    }
                    }.resume()
            } else {
                print("Fail to create url")
            }
            
        }
    }

  
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if messages.count > 0 {
            return messages.count
        }
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageTableViewCell", for: indexPath) as! MessageTableViewCell
        
        //Configure the cell...
        
        if (messages.count == 0) {
            cell.message = Message(name: "Loading...", date:"", message:"", id:0, authorId: 0, replies: [])
            cell.countResponse = 0
        }
        else {
            cell.message = messages[indexPath.row]
            cell.countResponse = messages[indexPath.row].replies.count
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "responseSegue" {
            if let vc = segue.destination as? ResponseTableViewController,
                let send = sender as? MessageTableViewCell {
                var replies: [Response] = []
                if let thisMessage = send.message {
                    for value in thisMessage.replies {
                        if let date = value["created_at"] as? String,
                            let nameDic = value["author"] as? NSDictionary,
                            let response = value["content"] as? String,
                            let id = value["id"] as? Int,
                            let name = nameDic["login"] as? String,
                            let authorId = nameDic["id"] as? Int {
                                replies.append(Response(name: name, date: date, response: response, id: id, authorId: authorId))
                            }
                    }
                
                    vc.responses = replies
                }
            }
        }
    }
}
