//
//  ServiceDetailModel.swift
//  HomeServices
//
//  Created by Navaldeep Kaur on 30/03/20.
//  Copyright © 2020 Atinder Kaur. All rights reserved.
//
import Foundation

// MARK: - ServiceDetailModel
struct ServiceDetailModel: Codable {
    let code: Int?
    let message: String?
    let body: BodyDetail?
}

// MARK: - Body
struct BodyDetail: Codable {
    let id :String?
    let name, description, price: String?
    let icon, thumbnail: String?
    //let serviceType: ServiceType1?
    let rating: Int?
    let type, duration, turnaroundTime: String?
    let includedServices, excludedServices: [String]?
    let category: Category?

}

// MARK: - ServiceType
struct ServiceType1: Codable {
    let name, type, price, duration: String
    let includedServices, excludedServices: [String]
    let turnaroundTime : String
}


struct IncludedServices{
  var  name: String?
  var  isIncluded:Bool?
    
    init(name:String?,isIncluded:Bool?){
        self.name = name
        self.isIncluded = isIncluded
    }
}
