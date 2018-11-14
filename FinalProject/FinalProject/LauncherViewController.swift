//
//  ViewController.swift
//  FinalProject
//
//  Created by Giselle Tavares on 02/11/18.
//  Copyright © 2018 Giselle Tavares. All rights reserved.
//

import UIKit
import Firebase

class LauncherViewController: UIViewController {
    
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = sb.instantiateViewController(withIdentifier: "loginVC")
            self.present(loginVC, animated: true, completion: nil)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let user = Auth.auth().currentUser {
            let childUpdates = ["lastLogin": Date().currentDateTime]
            ref.child("users/profile/\(user.uid)").updateChildValues(childUpdates)
            
            self.performSegue(withIdentifier: "navMenuVC", sender: self)
        }
    }

}

