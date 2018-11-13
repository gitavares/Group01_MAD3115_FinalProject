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
}

//private var __maxLengths = [UITextField: Int]()
//
//extension UITextField {
//    var maxLength: Int {
//        get {
//            guard let l = __maxLengths[self] else {
//                return 150 // (global default-limit. or just, Int.max)
//            }
//            return l
//        }
//        set {
//            __maxLengths[self] = newValue
//            addTarget(self, action: #selector(fix), for: .editingChanged)
//        }
//    }
//    @objc func fix(textField: UITextField) {
//        let t = textField.text
//        textField.text = t?.safelyLimitedTo(length: __maxLengths)
//    }
//}
//
//extension String
//{
//    func safelyLimitedTo(length n: Int)->String {
//        if (self.count <= n) {
//            return self
//        }
//        return String( Array(self).prefix(upTo: n) )
//    }
//}