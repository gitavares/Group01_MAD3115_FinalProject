//
//  AddTicketViewController.swift
//  FinalProject
//
//  Created by Antonio Merendaz do Carmo Nt on 2018-11-13.
//  Copyright © 2018 Medtouch. All rights reserved.
//

import UIKit
import Firebase

class AddTicketViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var alertMessage = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var imgBrand: UIImageView!

    @IBOutlet weak var txtPlate: UITextField!

    @IBOutlet weak var txtMake: UITextField!

    @IBOutlet weak var txtColor: UITextField!

    @IBOutlet weak var txtHours: UITextField!

    @IBOutlet weak var txtLot: UITextField!

    @IBOutlet weak var txtSpot: UITextField!
    
    @IBOutlet weak var txtPaymentMethod: UITextField!

    @IBOutlet weak var lblTimeStamp: UILabel!

    @IBOutlet weak var lblTotal: UILabel!
    var multiPicker : UIPickerView!
    var textField_Edit : UITextField!
    var makes = [String]()
    var colors = [String]()
    var lots = [String]()
    var spots = [String]()
    var timings = [String]()
    var payments = [String]()
    var ticketAmount = Double()
    var currentData = [String]()
    var ticketDetails = [String : String]()
    var logoImg = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        lblTimeStamp.text = "\(Date().currentDateTime)"
        self.title = "Add Ticket"
        
        txtPlate.text! = "ABC1234"
        txtMake.text! = "Acura"
        txtColor.text! = "Black"
        txtHours.text! = "1.0"
        txtLot.text! = "Lane A"
        txtSpot.text! = "P1"
        txtPaymentMethod.text! = "Credit Card"
        lblTimeStamp.text! = Date().currentDateTime
        lblTotal.text! = "$ 10.00"

        
        //FOR TESTS ONLY
        txtPlate.text = "ABC1234"
        
        //Opening Ticket.plist, containing data to put on the PickerViews:
        if let path = Bundle.main.path(forResource: "Ticket", ofType: "plist")
        {
            if let contents = NSDictionary(contentsOfFile: path) as? [String : AnyObject]
            {
                let makesList = contents["Makes"] as! [AnyObject]
                for make in makesList
                {
                    makes.append(make as! String)
                }
                let colorsList = contents["Colors"] as! [AnyObject]
                for color in colorsList
                {
                    colors.append(color as! String)
                }
                let lotsList = contents["Lot"] as! [AnyObject]
                for lot in lotsList
                {
                    lots.append(lot as! String)
                }
                let spotsList = contents["Spot"] as! [AnyObject]
                for spot in spotsList
                {
                    spots.append(spot as! String)
                }
                let timingsList = contents["Timing"] as! [AnyObject]
                for timing in timingsList
                {
                    timings.append(timing as! String)
                }
                let paymentsList = contents["PaymentMethod"] as! [AnyObject]
                for payment in paymentsList
                {
                    payments.append(payment as! String)
                }
            }
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        if (textField != txtPlate)
        {
            self.textField_Edit = textField
            self.pickData(textField)
            switch textField
            {
            case txtMake:
                self.currentData = self.makes
            case txtColor:
                self.currentData = self.colors
            case txtHours:
                self.currentData = self.timings
            case txtLot:
                self.currentData = self.lots
            case txtSpot:
                self.currentData = self.spots
            case txtPaymentMethod:
                self.currentData = self.payments
            default:
                return
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return self.currentData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currentData[row]
    }
    
    //MARK:- Function of datePicker
    func pickData(_ textField : UITextField){
        //Change that
        self.multiPicker = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.multiPicker.backgroundColor = UIColor.white
        multiPicker.delegate = self
        multiPicker.dataSource = self
        textField.inputView = self.multiPicker
        
        // Adding ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.backgroundColor = .cyan
        toolBar.tintColor = UIColor (red: 1/255, green: 25/255, blue: 147/255, alpha: 1)//Color => Midnight
        toolBar.sizeToFit()
        
        // Adding ToolBar Button
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
    
    // MARK:- Buttons Done and Cancel Actions
    @objc func doneClick()
    {
        textField_Edit.text = currentData[multiPicker.selectedRow(inComponent: 0)]
        if (textField_Edit == txtMake)
        {
            imgBrand.image = UIImage(named: currentData[multiPicker.selectedRow(inComponent: 0)])
        }
        textField_Edit.resignFirstResponder()
    }
    @objc func cancelClick() {
        textField_Edit.resignFirstResponder()
    }
    
    
    @IBAction func btnDone(_ sender: UIButton)
    {
//        FOR TESTS ONLY
        ticketAmount = (10.0*Double(txtHours.text!)!)
        lblTotal.text = "\(ticketAmount.curr())"
        
        saveTicket() { success in
            if success {
                print("ticket added")
    //                let sb = UIStoryboard(name: "Main", bundle: nil)
    //                let navMenuVC = sb.instantiateViewController(withIdentifier: "navMenuVC")
    //                self.present(navMenuVC, animated: true, completion: nil)
                self.performSegue(withIdentifier: "toPreviewVC", sender: self)
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
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let email = Auth.auth().currentUser?.email else { return }
        
        let databaseRef = Database.database().reference().child("users/profile/\(uid)/tickets/\(id)")
        var ticketObject = ["carPlate": txtPlate.text!,
                            "carMake": txtMake.text!,
                            "color": txtColor.text!,
                            "timing": txtHours.text!,
                            "lot": txtLot.text!,
                            "spot": txtSpot.text!,
                            "paymentMethod": txtPaymentMethod.text!,
                            "date": Date().currentDateTime,
                            "ticketAmount": ticketAmount]
            as [String:Any]
        databaseRef.setValue(ticketObject) { error, ref in
            completion(error == nil)
        }
        ticketObject["ticketAmount"] = String(ticketAmount)
        ticketObject["date"] = Date().dateOnlyDate
        ticketDetails = ticketObject as! [String : String]
        ticketDetails ["id"] = "\(id)"
        ticketDetails ["logoImage"] = self.logoImg
        ticketDetails ["email"] = email
    }
 
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PreviewViewController
        {
            vc.ticketDetails = self.ticketDetails
        }  
     }
}
