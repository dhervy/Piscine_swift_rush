//
//  TableViewController.swift
//  rush
//
//  Created by Duane HERVY on 1/13/19.
//  Copyright © 2019 Duane HERVY. All rights reserved.
//

import UIKit
import WebKit

class TableViewController: UITableViewController {

    let CLIENT_ID = "8c02ab138031f17e45b8a15535ccd24ec6cb2b284afc3292d2609673e3475d68"
    let CLIENT_SECRET = "21beb4e33cfac13ee077cc9877cbe548b689b4893f032a9c3e3fb17a1aeb0a7e"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.code == nil {
            getAuth()
        }
    }
    
    var Topics: [Topic] = []
    var code: String?{
        didSet {
            getToken()
        }
    }
    var token: String? {
        didSet {
            DispatchQueue.main.async {
                self.navigationController?.isNavigationBarHidden = false
            }
            getTopic()
//            getTopic()
//            User = UserInfo(token: token!, scheme: scheme, host: host)
//            User?.getUserInfo()
        }
    }
    
    func getTopic() {
        var urlComponent = URLComponents(string: "https://api.intra.42.fr/v2/topics")!
        
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
                                
                                for value in test{
                                    if let date = value["created_at"] as? String,
                                        let nameDic = value["author"] as? NSDictionary,
                                        let topic = value["name"] as? String,
                                        let id = value["id"] as? Int,
                                        let name = nameDic["login"] as? String {
                                            self.Topics.append(Topic(name: name, date: date, topic: topic, id: id, authorId: 0))
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
    
    func getAuth() {
        self.navigationController?.isNavigationBarHidden = true
        var urlComponent = URLComponents(string: "https://api.intra.42.fr/oauth/authorize")!
        
        urlComponent.queryItems = [
            URLQueryItem(name: "client_id", value: CLIENT_ID),
            URLQueryItem(name: "redirect_uri", value: "dhervy.rush://authorize"),
            URLQueryItem(name: "response_type", value: "code")
        ]
        
        urlComponent.percentEncodedQuery = urlComponent.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        if let url = urlComponent.url {
            let webView = UIWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
            self.view.addSubview(webView)
            webView.loadRequest(URLRequest(url: url))
        }
    }
    
    func getToken() {
        self.navigationController?.isNavigationBarHidden = true
        var urlComponent = URLComponents(string: "https://api.intra.42.fr/oauth/token")!
        
        urlComponent.queryItems = [
            URLQueryItem(name: "client_id", value: self.CLIENT_ID),
            URLQueryItem(name: "client_secret", value: self.CLIENT_SECRET),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "redirect_uri", value: "dhervy.rush://authorize")
        ]
        
        if let url = urlComponent.url {
            var request = URLRequest(url:url)
            request.httpMethod = "POST"
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                (data, response, error) in
                if let d = data {
                    do {
                        if let dic : NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                            print("\n\n\(dic)\n\n")
                            if let access_token = dic["access_token"] as? String {
                                self.token = access_token
                            } else {
                                print("no token...")
                            }
                        }
                    }
                    catch (let err) {
                        print(err)
                    }
                }
            }
            task.resume()
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if Topics.count > 0 {
            return Topics.count
        }
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        
        //Configure the cell...
        
        if (Topics.count == 0) {
            cell.topic = Topic(name: "Loading...", date:"", topic:"", id:0, authorId: 0)
        }
        else {
            cell.topic = Topics[indexPath.row]
        }
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MessageSegue" {
            if let vc = segue.destination as? MessageTableViewController,
                let send = sender as? TableViewCell {
                    vc.token = self.token!
                    vc.id = (send.topic?.id)!
            }
        }
    }

}
