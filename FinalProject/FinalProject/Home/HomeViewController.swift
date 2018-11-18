//
//  HomeViewController.swift
//  FinalProject
//
//  Created by Giselle Tavares on 17/11/18.
//  Copyright © 2018 Giselle Tavares. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    var ref: DatabaseReference = Database.database().reference()
    
    @IBOutlet weak var lblNumTotalTickets: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Home"

        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        ref.child("users/profile/\(uid)/tickets").observe(.value, with: { snapshot in
            self.lblNumTotalTickets.text = "\(snapshot.childrenCount)" 
        })
    }

}
