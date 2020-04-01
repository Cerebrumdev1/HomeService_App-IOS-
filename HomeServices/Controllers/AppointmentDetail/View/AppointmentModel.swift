//
//  AppointmentModel.swift
//  HomeServices
//
//  Created by Navaldeep Kaur on 01/04/20.
//  Copyright © 2020 Atinder Kaur. All rights reserved.
//

import Foundation

// MARK: - AppointmentModel
struct AppointmentModel: Codable {
    let code: Int?
    let message: String?
    let body: BodyAppointment?
}

// MARK: - Body
struct BodyAppointment: Codable {
    let id, serviceID, dayParts, time: String?
    let leave: String?
    let status, createdAt: Int?
    let service: ServiceAppointment?

}

// MARK: - Service
struct ServiceAppointment: Codable
{
    let icon, thumbnail: String?
    let name, description: String?

}
