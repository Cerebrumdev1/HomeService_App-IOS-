//
//  SubCategoriesModel.swift
//  Fleet Management
//
//  Created by Navaldeep Kaur on 25/03/20.
//  Copyright © 2020 Seasia Infotech. All rights reserved.
//

import Foundation

// MARK: - SubCategoriesModel
struct SubCategoriesModel : Codable {
    let code: Int?
    let message: String?
    let body: [BodyList]?
}

// MARK: - Body
struct BodyList: Codable {
    let name, bodyDescription, price: String?
    let icon, thumbnail: String?
    let category: Category?
    let serviceType: ServiceType?
    let rating: Int?
}

// MARK: - Category
struct Category: Codable {
    let name: String?
    let icon, thumbnail: String?
}

// MARK: - ServiceType
struct ServiceType: Codable {
    let name, type, price: String?
}
