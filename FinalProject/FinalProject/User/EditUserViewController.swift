//
//  EditUserViewController.swift
//  FinalProject
//
//  Created by Giselle Tavares on 12/11/18.
//  Copyright © 2018 Giselle Tavares. All rights reserved.
//

import UIKit
import Firebase

class EditUserViewController: UIViewController {

    var ref: DatabaseReference!
    var refHandle: DatabaseHandle!
    
    
    
    // pending -- backlog
    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtContactNumber: UITextField!
    @IBOutlet weak var txtCarPlateNumber: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let email = Auth.auth().currentUser?.email else { return }
        
        ref = Database.database().reference()
        ref.child("users/profile/\(uid)").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let name = value?["name"] as? String ?? ""
            let contactNumber = value?["contactNumber"] as? String ?? ""
            let carPlateNumber = value?["carPlateNumber"] as? String ?? ""
            
            self.txtName.text = "\(name)"
            self.txtContactNumber.text = "\(contactNumber)"
            self.txtCarPlateNumber.text = "\(carPlateNumber)"
        })
        
        self.txtEmail.text = "\(email)"
        
//        refHandle = ref.child("users/profile/\(uid)").observe(.childAdded, with: {
//            (data) in
//        })
        
        
//        let userID = Auth.auth().currentUser?.uid
//        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
//            // Get user value
//            let value = snapshot.value as? NSDictionary
//            let username = value?["username"] as? String ?? ""
//            let user = User(username: username)
//
//            // ...
//        }) { (error) in
//            print(error.localizedDescription)
//        }

        
        
        
        self.txtEmail.isEnabled = false
        
        
        
    }
    
    
    @IBAction func btnEditUser(_ sender: UIButton) {
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
