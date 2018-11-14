//
//  AddTicketViewController.swift
//  FinalProject
//
//  Created by Antonio Merendaz do Carmo Nt on 2018-11-13.
//  Copyright © 2018 Giselle Tavares. All rights reserved.
//

import UIKit

class AddTicketViewController: UIViewController {
    
    @IBOutlet weak var imgBrand: UIImageView!
    
    @IBOutlet weak var txtPlate: UITextField!
    
    @IBOutlet weak var txtBrand: UITextField!
    
    @IBOutlet weak var txtColor: UITextField!
    
    @IBOutlet weak var txtHours: UITextField!
    
    @IBOutlet weak var txtLocation: UITextField!

    @IBOutlet weak var txtPaymentMethod: UITextField!

    @IBOutlet weak var lblTimeStamp: UILabel!
    
    
    @IBOutlet weak var lblTotal: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        lblTimeStamp.text = "\(Date().currentDateTime)"
        self.title = "Add Ticket"
        
    }
    
    @IBAction func btnDone(_ sender: UIButton)
    {
        print("CAR PLATE: \(txtPlate.text!)")
        print("CAR BRAND: \(txtBrand.text!)")
        print("CAR COLOR: \(txtColor.text!)")
        print("CAR HOURS: \(txtHours.text!)")
        print("CAR LOCATION: \(txtLocation.text!)")
        print("PAYMENT METHOD: \(txtPaymentMethod.text!)")
     
              let id = Int.random(in: 0 ... 1000000) // implemented
        print("ID GENERATED: \(id)")
        
        
        /*
         validationForm { (success) -> Void in
         if success {
         registerUser()
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
         
         guard let email = txtEmail.text, txtEmail.text?.count != 0 else {
         self.alertMessage.alertMessage(message: "Please, enter your Email")
         self.present((self.alertMessage.alert ?? nil)!, animated: true, completion: nil)
         completion(false)
         return
         }
         
         if validateEmail(email: txtEmail.text!) == false {
         self.alertMessage.alertMessage(message: "Please, enter a valid Email")
         self.present((self.alertMessage.alert ?? nil)!, animated: true, completion: nil)
         completion(false)
         }
         
         guard let password = txtPassword.text, txtPassword.text?.count != 0 else {
         self.alertMessage.alertMessage(message: "Please, enter a password")
         self.present((self.alertMessage.alert ?? nil)!, animated: true, completion: nil)
         completion(false)
         
         return
         }
         
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
         
         completion(true)
         }
         
         func validateEmail(email: String) -> Bool {
         let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
         return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
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
         
         func registerUser() {
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
         carPlateNumber: self.txtCarPlateNumber.text!,
         lastLogin: Date().currentDateTime
         ) { success in
         if success {
         let sb = UIStoryboard(name: "Main", bundle: nil)
         let navMenuVC = sb.instantiateViewController(withIdentifier: "navMenuVC")
         self.present(navMenuVC, animated: true, completion: nil)
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
         
         func saveUserProfile(name: String, contactNumber: String, carPlateNumber: String, lastLogin: String, completion: @escaping ((_ success: Bool) -> ())) {
         
         guard let uid = Auth.auth().currentUser?.uid else { return }
         
         let databaseRef = Database.database().reference().child("users/profile/\(uid)")
         let userObject = [
         "name": name,
         "contactNumber": contactNumber,
         "carPlateNumber": carPlateNumber,
         "lastLogin": lastLogin
         ] as [String:Any]
         
         //        let databaseRef = Database.database().reference().child("users/profile/\(uid)/tickets/\(id)")
         //        let ticketObject = [
         //            "carPlate": carPlate,
         //            "carMake": carMake,
         //            "color": color,
         //            "timing": timing,
         //            "lot": lot,
         //            "spot": spot,
         //            "paymentMethod": paymentMethod,
         //            "date": Date().currentDateTime,
         //            ] as [String:Any]
         //        databaseRef.setValue(ticketObject) { error, ref in
         //            completion(error == nil)
         //        }
         
         databaseRef.setValue(userObject) { error, ref in
         completion(error == nil)
         }
         
         }
 
        */
        
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
