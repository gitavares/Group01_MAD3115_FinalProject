//
//  PreviewViewController.swift
//  FinalProject
//
//  Created by Antonio Merendaz do Carmo Nt on 2018-11-17.
//  Copyright © 2018 Giselle Tavares. All rights reserved.
//

import UIKit
import WebKit

class PreviewViewController: UIViewController {
    var ticketComposer: TicketComposer!
    var HTMLContent: String!
    var ticketDetails = [String : String]()
    
    @IBOutlet weak var myWebView: WKWebView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    func createTicketAsHTML() {
        ticketComposer = TicketComposer()
        if let ticketHTML = ticketComposer.renderTicket(ticketDetails: ticketDetails)
        {
            self.myWebView.loadHTMLString(ticketHTML, baseURL: nil)
            HTMLContent = ticketHTML
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createTicketAsHTML()
    }
    
    @IBAction func btnGeneratePDF(_ sender: UIBarButtonItem)
    {
        ticketComposer.exportHTMLContentToPDF(HTMLContent: HTMLContent)
        let testURL = URL(fileURLWithPath: ticketComposer.pdfFilename)
        // Display preview
        let previewController = UIDocumentInteractionController(url: testURL)
        previewController.delegate = self
        previewController.presentPreview(animated: true)
    }
}

extension PreviewViewController: UIDocumentInteractionControllerDelegate {
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return navigationController!
    }
}
