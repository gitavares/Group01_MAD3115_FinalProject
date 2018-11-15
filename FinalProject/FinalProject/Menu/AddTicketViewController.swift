//
//  AddTicketViewController.swift
//  FinalProject
//
//  Created by Antonio Merendaz do Carmo Nt on 2018-11-13.
//  Copyright © 2018 Giselle Tavares. All rights reserved.
//

import UIKit
import Firebase

class AddTicketViewController: UIViewController {
    
    var alertMessage = UIApplication.shared.delegate as! AppDelegate
    
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
        
        
        
        saveTicket() { success in
            if success {
                print("ticket added")
//                let sb = UIStoryboard(name: "Main", bundle: nil)
//                let navMenuVC = sb.instantiateViewController(withIdentifier: "navMenuVC")
//                self.present(navMenuVC, animated: true, completion: nil)
            } else {
                print("some error creating the ticket")
            }
        }
        
    }
    
    func saveTicket(completion: @escaping ((_ success: Bool) -> ())){
        
        guard let _ = txtPlate.text, txtPlate.text?.count != 0 else {
            self.alertMessage.alertMessage(message: "Please, enter a car plate number")
            self.present((self.alertMessage.alert ?? nil)!, animated: true, completion: nil)
            return
        }
        
        let id = Int.random(in: 0 ... 1000000) // implemented
        
        print("ID GENERATED: \(id)")
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let databaseRef = Database.database().reference().child("users/profile/\(uid)/tickets/\(id)")
        let ticketObject = ["carPlate": txtPlate.text!,
                            "carMake": txtBrand.text!,
                            "color": txtColor.text!,
                            "timing": txtHours.text!,
                            "lotSpot": txtLocation.text!,
                            "paymentMethod": txtPaymentMethod.text!,
                            "date": Date().currentDateTime,]
            as [String:Any]
        databaseRef.setValue(ticketObject) { error, ref in
            completion(error == nil)
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
    
}
