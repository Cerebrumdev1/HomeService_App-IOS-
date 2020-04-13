//
//  PromoCodeModel.swift
//  HomeServices
//
//  Created by Navaldeep Kaur on 08/04/20.
//  Copyright © 2020 Atinder Kaur. All rights reserved.
//

import Foundation

// MARK: - PromoCodeModel
struct PromoCodeModel: Codable {
    let code: Int?
    let message: String?
    let body: [Body]?
    
    // MARK: - Body
    struct Body: Codable {
        let icon, thumbnail: String?
        let id, name, code, discount: String?
        let description, type, validupto, companyId: String?
        let userId: String?
        let createdAt: Int?

    }

}


//MARK:- Apply Coupon Model

struct ApplyCouponModel: Codable {
    let code: Int?
    let message: String?
    let body: Body?
    
    // MARK: - Body
    struct Body: Codable
    {
        let totalAmount, discountPrice, payableAmount: Int?
        let coupanId, coupanCode, coupanDiscount: String?
    }
}


