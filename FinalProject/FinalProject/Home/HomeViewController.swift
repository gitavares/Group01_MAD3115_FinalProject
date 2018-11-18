//
//  HomeViewController.swift
//  FinalProject
//
//  Created by Gurjeet kaur on 2018-11-15.
//  Copyright © 2018 Giselle Tavares. All rights reserved.
//

import UIKit
import Firebase
class HomeViewController: UIViewController {
var ref: DatabaseReference = Database.database().reference()
    override func viewDidLoad() {
        super.viewDidLoad()
        //FirebaseApp.configure()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        //var ref: DatabaseReference = Database.database().reference()
        //ref = Database.database().reference()
        ref.child("users/profile/\(uid)/tickets").observe(.value, with: { snapshot in
            print(snapshot.childrenCount)
            
   })
}
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



