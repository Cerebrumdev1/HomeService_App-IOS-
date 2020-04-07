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
    let code: Int
    let message: String
    let body: [Body]
}

// MARK: - Body
struct Body: Codable {
    let id, serviceID, serviceDateTime, orderPrice: String
    let quantity, orderTotalPrice, addressID, companyID: String
    let userID: String
    let createdAt, updatedAt: Int
    let address: Address
    let service: Service

  // MARK: - Service
    struct Service: Codable {
//        let icon, thumbnail: String
//        let id, name, description: String
//        let serviceType: ServiceType
        
            let icon: String?
           let thumbnail: String?
           let includedServices, excludedServices: [String]?
           let id, name, serviceDescription, price: String?
           let type, duration, turnaroundTime: String?
           let createdAt, status: Int?

        // MARK: - ServiceType
//        struct ServiceType: Codable {
//            let name, type, price: String
//        }
    }
}

// MARK: - Address
struct Address: Codable {
    let id, addressName, addressType, houseNo: String
    let latitude, longitude, town, landmark: String
    let city: String
}



