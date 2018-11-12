//
//  AppDelegate.swift
//  FinalProject
//
//  Created by Giselle Tavares on 02/11/18.
//  Copyright © 2018 Giselle Tavares. All rights reserved.
//

import UIKit
import Firebase
//import GoogleSignIn
//import FirebaseUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var alert: UIAlertController?
    
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
//        let authUI = FUIAuth.defaultAuthUI()
//        authUI?.delegate = self as? FUIAuthDelegate
//
//        let providers: [FUIAuthProvider] = [
//            FUIGoogleAuth()
//        ]
//        authUI?.providers = providers
        
//        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
//        GIDSignIn.sharedInstance().delegate = self as? GIDSignInDelegate
        
        return true
    }
    
    // https://codelabs.developers.google.com/codelabs/firebase-ios-swift/#4
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
//        if let error = error {
//            print("Error \(error)")
//            return
//        }
//
//        guard let authentication = user.authentication else { return }
//        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
//                                                       accessToken: authentication.accessToken)
//        Auth.auth().signInAndRetrieveData(with: credential) { (user, error) in
//            if let error = error {
//                print("Error \(error)")
//                return
//            }
//        }
//    }

    func alertMessage(message: String){
        alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert!.addAction(UIAlertAction(title: "Try again", style: .default, handler: nil))
//        self.present(alert, animated: true)
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


}

