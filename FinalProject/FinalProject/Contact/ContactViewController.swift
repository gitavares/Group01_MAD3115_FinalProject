//
//  ContactViewController.swift
//  FinalProject
//
//  Created by Giselle Tavares on 13/11/18.
//  Copyright © 2018 Giselle Tavares. All rights reserved.
//

import UIKit
import MessageUI

class ContactViewController: UIViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Contact"
    }

    @IBAction func btnCall(_ sender: UIButton) {
        if let url = URL(string: "tel://+198765432100)"), UIApplication.shared.canOpenURL(url){
            if #available(iOS 10, *)
            {
                UIApplication.shared.open(url)
            }
            else
            {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    @IBAction func btnEmail(_ sender: UIButton) {
        if MFMailComposeViewController.canSendMail() {
            let picker = MFMailComposeViewController()
            picker.mailComposeDelegate = self
            picker.setToRecipients(["parkinglot@parkinglot.ca", "gitavares@gmail.com"])
            picker.setSubject("Contact by Parking Lot App")
            picker.setMessageBody("Hi", isHTML: true)

            present(picker, animated: true, completion: nil)
        } else {
            print("cant send email")
        }
    }
    
    // MFMailComposeViewControllerDelegate
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
        dismiss(animated: true, completion: nil)
    }
    
}
