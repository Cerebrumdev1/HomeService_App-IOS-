//
//  AddToCartInputModel.swift
//  HomeServices
//
//  Created by Navaldeep Kaur on 03/04/20.
//  Copyright © 2020 Atinder Kaur. All rights reserved.
//

import Foundation

struct  AddtoCartInputModel
{
    let serviceId:String?
    let addressId:String?
    let serviceDateTime: String?
    let orderPrice: String?
    let quantity: String?
    let orderTotalPrice:String?

    init(serviceId:String?,addressId:String?,serviceDateTime:String?,orderPrice:String?,quantity:String?,orderTotalPrice:String?) {
        self.serviceId = serviceId
        self.addressId = addressId
        self.serviceDateTime = serviceDateTime
        self.orderPrice = orderPrice
        self.quantity = quantity
        self.orderTotalPrice = orderTotalPrice
    }
    
}

