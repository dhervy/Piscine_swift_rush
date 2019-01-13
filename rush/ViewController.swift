//
//  ViewController.swift
//  rush
//
//  Created by Duane HERVY on 1/13/19.
//  Copyright © 2019 Duane HERVY. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate {
    
//    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let webConfigutation = WKWebViewConfiguration()
//        webView = WKWebView(frame: .zero, configuration: webConfigutation)
//        webView.uiDelegate = self
//        view = webView
        getAuth()
    }
    @IBOutlet weak var testLabel: UILabel!
    
    func getAuth() {
        let CLIENT_ID = "8c02ab138031f17e45b8a15535ccd24ec6cb2b284afc3292d2609673e3475d68"
        let CLIENT_SECRET = "21beb4e33cfac13ee077cc9877cbe548b689b4893f032a9c3e3fb17a1aeb0a7e"

        var urlComponent = URLComponents(string: "https://api.intra.42.fr/oauth/authorize")!
        
        urlComponent.queryItems = [
            URLQueryItem(name: "client_id", value: CLIENT_ID),
            URLQueryItem(name: "redirect_uri", value: "dhervy.rush://authorize"),
            URLQueryItem(name: "response_type", value: "code")
        ]
        
        urlComponent.percentEncodedQuery = urlComponent.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
//        webView.load(URLRequest(url: urlComponent.url!))
        if let url = urlComponent.url {
                UIApplication.shared.open(url)
        }
        
//        let request = NSMutableURLRequest(url: urlComponent.url!)
//        request.httpMethod = "GET"
//        request.setValue("Bearer " + self.token!, forHTTPHeaderField: "Authorization")
//        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
//        let task = URLSession.shared.dataTask(with: request as URLRequest) {
//            (data, response, error) in
//            if let err = error {
//                self.delegate?.handleError(error: err as NSError)
//            }
//            else if let d = data {
//                do {
//                    if let dict : NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
//                        if let tweets_resp = dict["statuses"] as? [NSDictionary] {
//                            for tweet in tweets_resp {
//                                if let user = tweet["user"] as? NSDictionary,
//                                    let date = tweet["created_at"] as? String,
//                                    let text = tweet["full_text"] as? String,
//                                    let name = user["name"] as? String {
//                                    let dateFormat = self.dateStringFormat(dateString: date)
//                                    self.tweets.append(Tweet(name: name, text: text, date: dateFormat))
//                                }
//                            }
//                            self.delegate?.handleTweet(tweets: self.tweets)
//                        }
//                    }
//                }
//                catch (let err) {
//                    self.delegate?.handleError(error: err as NSError)
//                }
//            }
//        }
//        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

