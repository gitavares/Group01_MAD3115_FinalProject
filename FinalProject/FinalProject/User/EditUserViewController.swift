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

    var alertMessage = UIApplication.shared.delegate as! AppDelegate
    var ref: DatabaseReference!
//    var refHandle: DatabaseHandle!
    
    
    
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
        self.txtEmail.isEnabled = false
        
    }
    
    
    @IBAction func btnEditUser(_ sender: UIButton) {
        validationForm { (success) -> Void in
            if success {
                saveUser()
            }
        }
    }
    
    func validationForm(completion: (_ success: Bool) -> Void) {
        guard let name = txtName.text, txtName.text?.count != 0 else {
            self.alertMessage.alertMessage(message: "Please, enter your Name")
            self.present((self.alertMessage.alert ?? nil)!, animated: true, completion: nil)
            completion(false)
            return
        }
        
        guard let contactNumber = txtContactNumber.text, txtContactNumber.text?.count != 0 else {
            self.alertMessage.alertMessage(message: "Please, enter a contact number")
            self.present((self.alertMessage.alert ?? nil)!, animated: true, completion: nil)
            completion(false)
            
            return
        }
        
        if validateContactNumber(contacNumber: txtContactNumber.text!) == false {
            self.alertMessage.alertMessage(message: "Please, enter a valid contact number")
            self.present((self.alertMessage.alert ?? nil)!, animated: true, completion: nil)
            completion(false)
        }
        
        guard let carPlateNumber = txtCarPlateNumber.text, txtCarPlateNumber.text?.count != 0 else {
            self.alertMessage.alertMessage(message: "Please, enter a car plate number")
            self.present((self.alertMessage.alert ?? nil)!, animated: true, completion: nil)
            completion(false)
            
            return
        }
        
        // validation only if the password was modified
        if let password = txtPassword.text, txtPassword.text?.count != 0 {
            
            if validatePassword(pw: txtPassword.text!) == false {
                self.alertMessage.alertMessage(message: "The password must be 6 characters long or more.")
                self.present((self.alertMessage.alert ?? nil)!, animated: true, completion: nil)
                completion(false)
            }
            
            if confirmPassword(pw: txtPassword.text!, pw2: txtConfirmPassword.text!) == false {
                self.alertMessage.alertMessage(message: "The repeated password doesn't match")
                self.present((self.alertMessage.alert ?? nil)!, animated: true, completion: nil)
                completion(false)
            }
            
        }
        
        completion(true)
    }
    
    func validatePassword(pw: String) -> Bool {
        if pw.count < 6 {
            return false
        }
        return true
    }
    
    func confirmPassword(pw: String, pw2: String) -> Bool {
        return pw2.elementsEqual(pw)
    }
    
    func validateContactNumber(contacNumber: String) -> Bool {
        let onlyNumberRegex = "^[0-9]*$"
        return NSPredicate(format: "SELF MATCHES %@", onlyNumberRegex).evaluate(with: contacNumber)
    }
    
    func saveUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let userData = ["uid": uid,
                    "name": txtName.text!,
                    "contactNumber": txtContactNumber.text!,
                    "carPlateNumber": txtCarPlateNumber.text!,
                    "lastLogin": Date().currentDateTime]
        let childUpdates = ["users/profile/\(uid)": userData]
        ref.updateChildValues(childUpdates)
        
        if txtPassword.text != "" {
            changePassword(newPassword: txtPassword.text!)
        }
        
        self.alertMessage.successMessage(message: "User data updated successfully!")
        self.present((self.alertMessage.alert ?? nil)!, animated: true, completion: nil)
    }
    
    func changePassword(newPassword: String) {
        let currentUser = Auth.auth().currentUser
        currentUser?.updatePassword(to: newPassword)
        
        self.alertMessage.successMessage(message: "User data and Password updated successfully!")
        self.present((self.alertMessage.alert ?? nil)!, animated: true, completion: nil)
    }

}
