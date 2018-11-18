//
//  InstructionViewController.swift
//  FinalProject
//
//  Created by Gurjeet kaur on 2018-11-14.
//  Copyright © 2018 Giselle Tavares. All rights reserved.
//

import UIKit
import WebKit

class InstructionViewController: UIViewController {

    @IBOutlet weak var WkWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Instructions"
        
        loadFromFile()
    }
    
    func loadFromFile() {
        let localfilePath = Bundle.main.url(forResource: "Instructions", withExtension: "html");
        let myRequest = URLRequest(url:localfilePath!)
        self.WkWebView.load(myRequest)
    }

}


