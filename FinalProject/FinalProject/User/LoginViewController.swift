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

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var alertMessage = UIApplication.shared.delegate as! AppDelegate
    var ref: DatabaseReference!

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtEmail.delegate = self
        txtPassword.delegate = self
        
        self.hideKeyboard()
        
        ref = Database.database().reference()
        
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        
        Auth.auth().signIn(withEmail: txtEmail.text!, password: txtPassword.text!) { user, error in
            if error == nil && user != nil {
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtEmail.resignFirstResponder()
        txtPassword.resignFirstResponder()
        return true
    }

}
