//
//  ParkingReportTableViewController.swift
//  FinalProject
//
//  Created by Giselle Tavares on 13/11/18.
//  Copyright © 2018 Giselle Tavares. All rights reserved.
//

import UIKit
import Firebase

class reuseIdentifier: UITableViewCell {
    
    @IBOutlet weak var lblDateTimeParking: UILabel!
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var imgCarMake: UIImageView!
    @IBOutlet weak var lblCarPlate: UILabel!
    @IBOutlet weak var lblCarMake: UILabel!
    @IBOutlet weak var lblColor: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblPaymentMethod: UILabel!
    @IBOutlet weak var lblLotSpot: UILabel!
    
}

class ParkingReportTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableReport: UITableView!
    var ref: DatabaseReference = Database.database().reference()
    var tickets = [Tickets]()
    let uid = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Report"
        tableReport.delegate = self
        tableReport.dataSource = self
        
        loadTickets()
        
    }

    func loadTickets() {
        ref.child("users/profile/\(uid!)/tickets").queryOrdered(byChild: "date").observe(.childAdded, with: { (snapshot) in
            
            let results = snapshot.value as? [String : AnyObject]
            let carMake = results?["carMake"]
            let carPlate = results?["carPlate"]
            let color = results?["color"]
            let date = results?["date"]
            let lot = results?["lot"]
            let paymentMethod = results?["paymentMethod"]
            let spot = results?["spot"]
            let ticketAmount = results?["ticketAmount"]
            let timing = results?["timing"]
            
            let allTickets = Tickets(carMake: carMake as! String?,
                                     carPlate: carPlate as! String?,
                                     color: color as! String?,
                                     date: date as! String?,
                                     lot: lot as! String?,
                                     paymentMethod: paymentMethod as! String?,
                                     spot: spot as! String?,
                                     ticketAmount: ticketAmount as! Double?,
                                     timing: timing as! String?)
            
            self.tickets.append(allTickets)
            
            DispatchQueue.main.async {
                self.tableReport.reloadData()
            }
        })
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickets.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! reuseIdentifier

        let ticket = tickets[indexPath.row]
        cell.imgCarMake?.image = UIImage(named: "\(ticket.carMake ?? "")")
        cell.lblCarMake?.text = "Car make: \(ticket.carMake ?? "")"
        cell.lblCarPlate?.text = "Car plate: \(ticket.carPlate ?? "")"
        cell.lblColor?.text = "Color:  \(ticket.color ?? "")"
        cell.lblDateTimeParking?.text = ticket.date
        cell.lblDuration?.text = "Duration: \(ticket.timing ?? "") hr(s)"
        cell.lblLotSpot?.text = "Lot: \(ticket.lot ?? "") | Spot: \(ticket.spot ?? "")"
        cell.lblPaymentMethod?.text = "Payment method: \(ticket.paymentMethod ?? "")"
        cell.lblTotalAmount?.text = "\(ticket.ticketAmount?.curr() ?? "")"
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // the height of each cell
        return 180
    }

}
