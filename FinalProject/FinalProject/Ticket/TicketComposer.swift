//
//  TicketComposer.swift
//  FinalProject
//
//  Created by Antonio Merendaz do Carmo Nt on 2018-11-18.
//  Copyright © 2018 Medtouch. All rights reserved.
//

import UIKit

class TicketComposer: NSObject
{
    let pathToTicketHTMLTemplate = Bundle.main.path(forResource: "ticket_template", ofType: "html")
    var paymentMethod = String()
    var logoImageURL = String()
    var ticketNumber = String()
    var pdfFilename = String()
    /*
    id => Type cast from Int to String
    totalAmount => from Double to String
    let ticketObject =
    */
    
    
    override init() {
        super.init()
    }
   
    func renderTicket(ticketDetails: [String: String]) -> String!
    {
//        self.ticketNumber = []
        var HTMLContent = String()
        
        do {
            // Load the invoice HTML template code into a String variable.
            HTMLContent = try String(contentsOfFile: pathToTicketHTMLTemplate!)
            
            // Replace all the placeholders with real values.
            // The logo image.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#LOGO#", with: ticketDetails["logoImage"]!)
            
            // Ticket number.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#TICKET_NUMBER#", with: ticketDetails["id"]!)
            
            // Ticket date.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#TICKET_DATE#", with:ticketDetails["date"]!)
            
            // Email.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#EMAIL#", with:ticketDetails["email"]!)
            
            // Car Plate.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#PLATE#", with: ticketDetails["carPlate"]!)
            
            // Car Make.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#MAKE#", with: ticketDetails["carMake"]!)
            
            // Color.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#COLOR#", with: ticketDetails["color"]!)
            
            // Timing.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#HOURS#", with: (ticketDetails["timing"]!+" Hr."))
            
            // Lot.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#LOT#", with: ticketDetails["lot"]!)
            
            // Spot.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#SPOT#", with: ticketDetails["spot"]!)
            
            // Payment method.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#PAYMENT_METHOD#", with: ticketDetails["paymentMethod"]!)
            
            // Total amount.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#TOTAL_AMOUNT#", with: ticketDetails["ticketAmount"]!)
        }
        catch {
            print("Unable to open and use HTML template files.")
        }
        
        return HTMLContent
    }
    
    func exportHTMLContentToPDF(HTMLContent: String) {
        let printPageRenderer = CustomPrintPageRenderer()
        
        let printFormatter = UIMarkupTextPrintFormatter(markupText: HTMLContent)
        printPageRenderer.addPrintFormatter(printFormatter, startingAtPageAt: 0)
        
        let pdfData = drawPDFUsingPrintPageRenderer(printPageRenderer: printPageRenderer)
        
        let outputFolderPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        pdfFilename = "\(outputFolderPath)/Ticket\(ticketNumber).pdf"
        pdfData!.write(toFile: pdfFilename, atomically: true)
        print(pdfFilename)
    }
    
    func drawPDFUsingPrintPageRenderer(printPageRenderer: UIPrintPageRenderer) -> NSData! {
        let data = NSMutableData()
        
        UIGraphicsBeginPDFContextToData(data, CGRect.zero, nil)
        
        UIGraphicsBeginPDFPage()
        
        printPageRenderer.drawPage(at: 0, in: UIGraphicsGetPDFContextBounds())
        
        UIGraphicsEndPDFContext()
        
        return data
    }
    
}
