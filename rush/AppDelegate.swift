//
//  AppDelegate.swift
//  rush
//
//  Created by Duane HERVY on 1/13/19.
//  Copyright © 2019 Duane HERVY. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func getQueryParams(url: URL, param: String) -> String? {
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        if let URLCompoment = urlComponents {
            if let params = URLCompoment.queryItems {
                for p in params {
                    if p.name == param {
                        return (p.value)
                    }
                }
            }
        }
        return (nil)
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        if let code = getQueryParams(url: url, param: "code") {
            print(code)
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            if let myViewController = mainStoryboard.instantiateViewController(withIdentifier: "viewController") as? ViewController {
                

                print("something")
                let button = myViewController.testLabel
                print("something")
                print(button)
                myViewController.testLabel?.text = code
                print(button?.text)
            }
        }
        return true
    }
}
