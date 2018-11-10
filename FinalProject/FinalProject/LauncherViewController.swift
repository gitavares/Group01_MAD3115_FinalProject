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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = sb.instantiateViewController(withIdentifier: "loginVC")
            self.present(loginVC, animated: true, completion: nil)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let user = Auth.auth().currentUser {
//            self.performSegue(withIdentifier: "testVC", sender: self)
            self.performSegue(withIdentifier: "menuVC", sender: self)
        }
    }


}

