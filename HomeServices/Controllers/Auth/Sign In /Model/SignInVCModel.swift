//
//  SignInVCModel.swift
//  Fleet Management
//
//  Created by Mohit Sharma on 2/20/20.
//  Copyright © 2020 Seasia Infotech. All rights reserved.
//

import Foundation
import ObjectMapper


struct SignIn_ResponseModel: Decodable
{
    var body :  data1?
    var code: Int?
    var message : String?
}


struct data1: Decodable
{
    var address : String?
    var companyId :String?
    var countryCode :String?
    var createdAt :Int?
    var deviceToken :String?
    var email :String?
    var firstName :String?
    var id :String?
    var image :String?
    var lastName :String?
    var moduleType : String?
    var password : String?
    var phoneNumber : String?
     var platform : String?
    var sessionToken : String?
    var status : Int?
    var updatedAt : Int?
    var userType : String?
}


