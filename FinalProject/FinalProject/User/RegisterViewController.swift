//
//  RegisterViewController.swift
//  FinalProject
//
//  Created by Giselle Tavares on 02/11/18.
//  Copyright © 2018 Giselle Tavares. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtContactNumber: UITextField!
    @IBOutlet weak var txtCarPlateNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnRegisterUser(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassword.text!) { user, error in
                if error == nil && user != nil {
                    print("user created")
                    
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = self.txtName.text!
                    
                    changeRequest?.commitChanges { error in
                        if error == nil {
                            self.saveUserProfile(
                                    name: self.txtName.text!,
                                    contactNumber: self.txtContactNumber.text!,
                                    carPlateNumber: self.txtCarPlateNumber.text!
                            ) { success in
                                if success {
                                    let sb = UIStoryboard(name: "Main", bundle: nil)
                                    let testVC = sb.instantiateViewController(withIdentifier: "testVC")
                                    self.present(testVC, animated: true, completion: nil)
                                }
                            }
                        } else {
                            print("Error saving User Profile: \(error)")
                        }
                    }
                    
                } else {
                    print("Error creating User: \(error)")
                }
            }
        
    }
    
    func saveUserProfile(name: String, contactNumber: String, carPlateNumber: String, completion: @escaping ((_ success: Bool) -> ())) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let databaseRef = Database.database().reference().child("users/profile/\(uid)")
        let userObject = [
            "name": name,
            "contactNumber": contactNumber,
            "carPlateNumber": carPlateNumber
        ] as [String:Any]
        
        databaseRef.setValue(userObject) { error, ref in
            completion(error == nil)
        }
        
    }

}
