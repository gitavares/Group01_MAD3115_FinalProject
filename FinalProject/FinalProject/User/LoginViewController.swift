//
//  LoginViewController.swift
//  FinalProject
//
//  Created by Giselle Tavares on 02/11/18.
//  Copyright © 2018 Giselle Tavares. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self as? GIDSignInUIDelegate
        GIDSignIn.sharedInstance().signInSilently()
        
        
//        handle = Auth.auth().addStateDidChangeListener() { (auth, user) in
//            if user != nil {
//                MeasurementHelper.sendLoginEvent()
//                self.performSegue(withIdentifier: Constants.Segues.SignInToFp, sender: nil)
//            }
//        }
    }
    
//    deinit {
//        if let handle = handle {
//            Auth.auth().removeStateDidChangeListener(handle)
//        }
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
