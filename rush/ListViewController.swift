////
////  ListViewController.swift
////  rush
////
////  Created by Duane HERVY on 1/13/19.
////  Copyright © 2019 Duane HERVY. All rights reserved.
////
//
//import UIKit
//
//class ListViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
//
////
////  ForumTableViewController.swift
////  Rush
////
////  Created by Thomas BERTOJO on 1/12/19.
////  Copyright © 2019 Thomas BERTOJO. All rights reserved.
////
//
//import UIKit
//
//class ForumTableViewController: UITableViewController {
//    
//    @IBAction func AddTopicBarButton(_ sender: UIBarButtonItem) {
//        performSegue(withIdentifier: "AddTopic", sender: "")
//    }
//    
//    @IBAction func LogoutButtonItem(_ sender: UIBarButtonItem) {
//        self.code = nil
//        self.getcode()
//    }
//    var Topics: [Topic] = []
//    
//    var scheme = "https"
//    var host = "api.intra.42.fr"
//    var User: UserInfo?
//    
//    var token: String? {
//        didSet {
//            DispatchQueue.main.async {
//                self.navigationController?.isNavigationBarHidden = false
//            }
//            getTopic()
//            User = UserInfo(token: token!, scheme: scheme, host: host)
//            User?.getUserInfo()
//        }
//    }
//    
//    func getcode() {
//        self.navigationController?.isNavigationBarHidden = true
//        let bundleId_uri = "tbertojo.Rush://authorize"
//        let queryItem1 = URLQueryItem(name: "client_id", value: client_id)
//        let queryItem2 = URLQueryItem(name: "redirect_uri", value: bundleId_uri)
//        //        let queryItem2 = URLQueryItem(name: "redirect_uri", value: "http://intra.42.fr")
//        let queryItem3 = URLQueryItem(name: "response_type", value: "code")
//        let queryItem4 = URLQueryItem(name: "tweet_mode", value: "extended")
//        var urlComponents = URLComponents()
//        urlComponents.scheme = "https"
//        urlComponents.host = "api.intra.42.fr"
//        urlComponents.path = "/oauth/authorize"
//        urlComponents.queryItems = [queryItem1, queryItem2, queryItem3, queryItem4]
//        
//        if let url = urlComponents.url {
//            //                UIApplication.shared.open(url)
//            //                self.title = "Login"
//            let webView = UIWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
//            self.view.addSubview(webView)
//            webView.loadRequest(URLRequest(url: url))
//        }
//    }
//    
//    let client_id = "a2346951de5d005f7846873dc8a182781bbfef13afcdca12804d84e32ef01932"
//    let client_secret = "e09ed2c59edba0a5378c2da24a3c6a6f73d04283a4ebd1d30f5e64145342c490"
//    
//    var code: String? {
//        didSet {
//            getToken()
//        }
//    }
//    
//    func getTopic() {
//        print("getTopic")
//        //        self.title = "Topic"
//        var urlComponents = URLComponents()
//        urlComponents.scheme = scheme
//        urlComponents.host = host
//        urlComponents.path = "/v2/topics"
//        if let url = urlComponents.url {
//            var request = URLRequest(url:url)
//            request.httpMethod = "GET"
//            request.setValue("Bearer " + token!, forHTTPHeaderField: "Authorization")
//            print(request)
//            URLSession.shared.dataTask(with: request as URLRequest) {
//                (data, response, error) in
//                print("URL session")
//                if let error = error {
//                    print("API GET", error)
//                }
//                //                print(response)
//                //                print(data)
//                //                print(error)
//                
//                if let d = data {
//                    print(data)
//                    do {
//                        if let results: NSArray = try JSONSerialization .jsonObject(with: d, options: JSONSerialization.ReadingOptions.allowFragments  ) as? NSArray {
//                            print("result !! \(results)")
//                            if let test = results as? [NSDictionary] {
//                                for value in test{
//                                    if let date = value["created_at"] as? String,
//                                        let nameDic = value["author"] as? NSDictionary,
//                                        let topic = value["name"] as? String,
//                                        let id = value["id"] as? Int,
//                                        let name = nameDic["login"] as? String{
//                                        print ("name \(name), topic \(topic), date \(date)")
//                                        //                                    self.Topics.append(Topic(name: name, date: date, topic: topic, id: 0))
//                                        //                                    let dateFormat = self.dateStringFormat(dateString: date)
//                                        self.Topics.append(Topic(name: name, date: date, topic: topic, id: id, authorId: 0))
//                                    }
//                                }
//                                print(self.Topics)
//                                DispatchQueue.main.async {
//                                    self.tableView.reloadData()
//                                }
//                                //                            for topic in dic as! [Dictionary<String, AnyObject>] {
//                                //                                guard let author = topic["name"] as? [String:AnyOBject] else {
//                                ////                                    return
//                                //                                }
//                                //                                guard let
//                            }
//                        }
//                        //                        }
//                    } catch let err {
//                        print("parse Error \(err)")
//                    }
//                }
//                }.resume()
//        } else {
//            print("?")
//        }
//        
//    }
//    //    func dateStringFormat(dateString: String) -> String {
//    //        let dateFormatter = DateFormatter()
//    //        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//    //        let date = dateFormatter.date(from: dateString)
//    //        dateFormatter.locale = Locale(identifier: "fr_FR")
//    //        dateFormatter.dateFormat = "d MMM yyyy HH:mm"
//    //        let dateFormat = dateFormatter.string(from: date!)
//    //        return dateFormat
//    //    }
//    func getToken() {
//        
//        let queryItem1 = URLQueryItem(name: "client_id", value: client_id)
//        let queryItem2 = URLQueryItem(name: "client_secret", value: client_secret)
//        let queryItem3 = URLQueryItem(name: "code", value: code)
//        let queryItem4 = URLQueryItem(name: "grant_type", value: "authorization_code")
//        let queryItem5 = URLQueryItem(name: "redirect_uri", value: "tbertojo.Rush://authorize")
//        var urlComponents = URLComponents()
//        urlComponents.scheme = "https"
//        urlComponents.host = "api.intra.42.fr"
//        urlComponents.path = "/oauth/token"
//        urlComponents.queryItems = [queryItem1, queryItem2, queryItem3, queryItem4, queryItem5]
//        
//        if let url = urlComponents.url {
//            var request = URLRequest(url:url)
//            request.httpMethod = "POST"
//            let task = URLSession.shared.dataTask(with: request as URLRequest) {
//                (data, response, error) in
//                if let d = data {
//                    do {
//                        if let dic : NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
//                            print(dic)
//                            //                            print(dic["access_token"]!)
//                            if let access_token = dic["access_token"] as? String {
//                                self.token = access_token
//                            } else {
//                                print("no token...")
//                            }
//                            //                            self.token = dic["access_token"]! as? String
//                        }
//                    }
//                    catch (let err) {
//                        print(err)
//                    }
//                }
//            }
//            task.resume()
//        }
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        if code == nil {
//            getcode()
//        }
//        // Uncomment the following line to preserve selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//        
//        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//        // self.navigationItem.rightBarButtonItem = self.editButtonItem
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    // MARK: - Table view data source
//    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        if Topics.count > 0 {
//            return Topics.count
//        }
//        return 1
//    }
//    
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ForumTableViewCell", for: indexPath) as! ForumTableViewCell
//        
//        //Configure the cell...
//        
//        if (Topics.count == 0) {
//            cell.topic = Topic(name: "Loading...", date:"", topic:"", id:0, authorId: 0)
//        }
//        else {
//            cell.topic = Topics[indexPath.row]
//        }
//        return cell
//    }
//    
//    
//    /*
//     // Override to support conditional editing of the table view.
//     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//     // Return false if you do not want the specified item to be editable.
//     return true
//     }
//     */
//    
//    
//    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
//    
//    
//    /*
//     // Override to support rearranging the table view.
//     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
//     
//     }
//     */
//    
//    /*
//     // Override to support conditional rearranging of the table view.
//     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//     // Return false if you do not want the item to be re-orderable.
//     return true
//     }
//     */
//    
//    /*
//     // MARK: - Navigation
//     
//     // In a storyboard-based application, you will often want to do a little preparation before navigation
//     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//     // Get the new view controller using segue.destinationViewController.
//     // Pass the selected object to the new view controller.
//     }
//     */
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "MessageSegue" {
//            let vc = segue.destination as! MessageTableViewController
//            let send = sender as! ForumTableViewCell
//            vc.idTopic = (send.topic?.id)!
//            vc.token = self.token!
//            print(send.topic?.id)
//            //            vc.toto = "haha"
//            
//        }
//    }
//    
//}
//
