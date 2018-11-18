//
//  Tickets.swift
//  FinalProject
//
//  Created by Giselle Tavares on 16/11/18.
//  Copyright © 2018 Giselle Tavares. All rights reserved.
//

import Foundation

class Tickets {
    var carMake: String?
    var carPlate: String?
    var color: String?
    var date: String?
    var lot: String?
    var paymentMethod: String?
    var spot: String?
    var ticketAmount: Double?
    var timing: String?
    
    init(
        carMake: String?,
        carPlate: String?,
        color: String?,
        date: String?,
        lot: String?,
        paymentMethod: String?,
        spot: String?,
        ticketAmount: Double?,
        timing: String?
        ) {
        
        self.carMake = carMake
        self.carPlate = carPlate
        self.color = color
        self.date = date
        self.lot = lot
        self.paymentMethod = paymentMethod
        self.spot = spot
        self.ticketAmount = ticketAmount
        self.timing = timing
    }
}
