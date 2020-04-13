//
//  AddToCartModel.swift
//  HomeServices
//
//  Created by Navaldeep Kaur on 03/04/20.
//  Copyright © 2020 Atinder Kaur. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct AddToCartModel : Codable
{
    let code: Int?
    let message: String?
   
}
//MARK:- Model Update cart

struct CartDetail: Codable
{
    let code: Int?
    let message: String?
    let body: Body?
 
    struct Body: Codable {
        let id, serviceId, serviceDateTime, orderPrice: String?
        let quantity, orderTotalPrice, addressId, companyId: String?
        let userId: String?
        let createdAt, updatedAt: Int?
        let address: Address?
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
        let includedServices, excludedServices: [String]?
        let id, name, serviceDescription, price: String?
        let type, duration, turnaroundTime: String?
        let createdAt, status: Int?

    }

}
