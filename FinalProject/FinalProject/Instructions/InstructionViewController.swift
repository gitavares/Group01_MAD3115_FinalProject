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
       // WKWebView.loadHTMLString(htmlString, baseURL: nil)
        navigationItem.title = "Instructions"
        
        loadFromFile()
        
        
    }
    
    func loadFromFile()
    {
        let localfilePath = Bundle.main.url(forResource: "Instructions", withExtension: "html");
        let myRequest = URLRequest(url:localfilePath!)
        self.WkWebView.load(myRequest)
        
    }


        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


