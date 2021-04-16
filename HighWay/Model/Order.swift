//
//  Order.swift
//  HighWay
//
//  Created by no one on 07/04/2021.
//

import Foundation
struct Order {
    var orderType = ""
    var orderDataTime : Date!
    var orderId = ""
    var orderStatus = ""
    var startLat = 0.0
    var startLong = 0.0
    var endLat = 0.0
    var endLong = 0.0
    var fuelOrderDate = ""
    var fuelOrderPrice = "0.0"
    var fuelOrderSize = ""
    var userAddress = ""
    var arriveAddress = ""
    var notes = ""
    var orderPrice = 0.0
    var driver : Driver?
   
    
}

