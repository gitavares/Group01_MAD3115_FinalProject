//
//  TestViewController.swift
//  FinalProject
//
//  Created by Giselle Tavares on 03/11/18.
//  Copyright © 2018 Giselle Tavares. All rights reserved.
//

import UIKit
import Firebase

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let user = Auth.auth().currentUser {
            // do something
        } else {
            backToLogin()
        }
    }
    
    // TEMP VC --> Logout will work on Menu file
    // https://codelabs.developers.google.com/codelabs/firebase-ios-swift/#4
    @IBAction func btnLogout(_ sender: UIButton) {
        try! Auth.auth().signOut()
        backToLogin()
    }
    
    func backToLogin() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = sb.instantiateViewController(withIdentifier: "loginVC")
        self.present(loginVC, animated: true, completion: nil)
    }

}
