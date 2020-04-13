//
//  OrderModel.swift
//  HomeServices
//
//  Created by Navaldeep Kaur on 02/04/20.
//  Copyright © 2020 Atinder Kaur. All rights reserved.
//

import Foundation

// MARK: - OrderModel

struct OrderModel: Codable {
    let code: Int?
    let message: String?
    let body: [Body]?
    
    // MARK: - Body
    struct Body: Codable {
     let id, serviceDateTime, orderPrice, promoCode: String?
        let offerPrice, serviceCharges, totalOrderPrice, addressID: String?
        let companyID, userID: String?
        let progressStatus, trackStatus: Int?
        let assignedEmployees: String
        let trackingLatitude, trackingLongitude, cancellationReason: String?
        let createdAt, updatedAt: Int?
        let address: Address?
        let suborders: [Suborder]?
        
        // MARK: - Suborder
        struct Suborder: Codable {
            let id, serviceId, quantity: String?
            let service: Service?
        }
        
        // MARK: - Address
        struct Address: Codable {
            let id, addressName, addressType, houseNo: String?
               let latitude, longitude, town, landmark: String?
               let city: String?
        }
        
        // MARK: - Service
      struct Service: Codable {
        let icon: String?
        let thumbnail: String?
        let id, name, serviceDescription, price: String?
        let type, duration: String?
        }
    }
    
}
