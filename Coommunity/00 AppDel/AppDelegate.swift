//
//  AppDelegate.swift
//  Coommunity
//
//  Created by ZSOAHM-24 on 15/02/18.
//  Copyright © 2018 Magic tech. All rights reserved.
//

import UIKit
import GoogleMaps

// Change this key to a valid key registered with the demo app bundle id.
//let kMapsAPIKey = "AIzaSyCNCTPCaueK66uJoF64AQT5P2gsVLFFGVg"
let kMapsAPIKey = "AIzaSyAhCuaSuJGlxTTOnRGGyzuY3nU9RuqeGi4"     // me

enum FeedType :String{
    case MapType
    case FullLength
}


public extension Notification {
    public class MyApp {
        public static let Something = Notification.Name("Notification.Coommunity.Something")
    }
}



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var postDisplayType : FeedType?
    
    var isLoginToApp : Bool?
    
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        postDisplayType = FeedType.MapType
        
        if kMapsAPIKey.isEmpty {
            fatalError("Please provide an API Key using kMapsAPIKey")
        }
        GMSServices.provideAPIKey(kMapsAPIKey)
   
        delayWithSeconds(2) {
            let rootViewController = self.window!.rootViewController as! UINavigationController
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            if let viewController = mainStoryboard.instantiateViewController(withIdentifier: "LandingScreenVctrID") as? LandingScreenVctr {
                    rootViewController.pushViewController(viewController, animated: true)
            }
        }
        userPrefrenceByDefaults()
        return true
    }
    func userPrefrenceByDefaults()  {
        UserDefaults.standard.register(defaults: ["isLoggedIn" : false])
    }
    
    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
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
    func checkUserIsLoggedIn() -> Bool {
        if UserDefaults.standard.bool(forKey: "isLoggedIn") {
            return true
        }else{
            return false
        }
    }
    func logInToApplication()  {
        let rootViewController = self.window!.rootViewController as! UINavigationController
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginNavCntrlID") as? UINavigationController {

            let button1 = UIBarButtonItem(image: UIImage(named: "ic_back_profile"), style: .plain, target: self, action: #selector(loginNavBack))
             button1.tintColor = UIColor.white
            viewController.navigationItem.rightBarButtonItem  = button1
            
            viewController.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            viewController.navigationBar.shadowImage = UIImage()

            rootViewController.present(viewController, animated: true, completion: nil)
        }
    }
    @objc func loginNavBack(){
        
    }
}

