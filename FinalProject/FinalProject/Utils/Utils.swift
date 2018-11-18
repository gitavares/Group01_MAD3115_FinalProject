//
//  Utils.swift
//  FinalProject
//
//  Created by Giselle Tavares on 05/11/18.
//  Copyright © 2018 Giselle Tavares. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    var currentDateTime: String {
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium

        return formatter.string(from: currentDateTime)
    }
    var dateOnlyDate: String {
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        return formatter.string(from: currentDateTime)
    }
}

extension Double
{
    func curr() -> String {
        return "$" + String(format: "%.2f", self)
    }
}

extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}
