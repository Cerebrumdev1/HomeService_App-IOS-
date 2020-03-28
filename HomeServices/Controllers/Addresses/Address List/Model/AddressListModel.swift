//
//  AddressListModel.swift
//  UrbanClap Replica
//
//  Created by Mohit Sharma on 3/24/20.
//  Copyright © 2020 Seasia Infotech. All rights reserved.
//

import Foundation

struct AddressList_ResponseModel: Decodable
{
    var code: Int?
    var message : String?
    var body :  [AddressList_Result?]
}

struct AddressList_Result: Decodable
{
    let id, addressName,addressType, latitude, longitude: String
    let town, landmark, city, companyID: String
    let userID: String
    let bodyDefault, status, createdAt, updatedAt: Int

    enum CodingKeys: String, CodingKey
    {
        case id, addressName,addressType, latitude, longitude, town, landmark, city
        case companyID = "companyId"
        case userID = "userId"
        case bodyDefault = "default"
        case status, createdAt, updatedAt
    }
}

