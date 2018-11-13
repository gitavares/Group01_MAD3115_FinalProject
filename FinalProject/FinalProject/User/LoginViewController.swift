//
//  LoginViewController.swift
//  FinalProject
//
//  Created by Giselle Tavares on 02/11/18.
//  Copyright © 2018 Giselle Tavares. All rights reserved.
//

import UIKit
import Firebase
//import GoogleSignIn

class LoginViewController: UIViewController {
    
    var alertMessage = UIApplication.shared.delegate as! AppDelegate
    var ref: DatabaseReference!

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
//        GIDSignIn.sharedInstance().uiDelegate = self as? GIDSignInUIDelegate
//        GIDSignIn.sharedInstance().signInSilently()
        
        
//        handle = Auth.auth().addStateDidChangeListener() { (auth, user) in
//            if user != nil {
//                MeasurementHelper.sendLoginEvent()
//                self.performSegue(withIdentifier: Constants.Segues.SignInToFp, sender: nil)
//            }
//        }
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        
        Auth.auth().signIn(withEmail: txtEmail.text!, password: txtPassword.text!) { user, error in
            if error == nil && user != nil {
//                self.dismiss(animated: false, completion: nil)
                self.saveLastLogin()
                
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let navMenuVC = sb.instantiateViewController(withIdentifier: "navMenuVC")
                self.present(navMenuVC, animated: true, completion: nil)
            } else {
                self.alertMessage.alertMessage(message: "Login/Password incorrect")
                self.present((self.alertMessage.alert ?? nil)!, animated: true, completion: nil)
            }
        }
        
    }
    
    func saveLastLogin() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let childUpdates = ["lastLogin": Date().currentDateTime]
        ref.child("users/profile/\(uid)").updateChildValues(childUpdates)
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
