//
//  AppointmentModel.swift
//  HomeServices
//
//  Created by Navaldeep Kaur on 01/04/20.
//  Copyright © 2020 Atinder Kaur. All rights reserved.
//

import Foundation

//// MARK: - AppointmentModel
//
//struct AppointmentModel
//{
//    let code: Int?
//    let message: String?
//    let body: Body12?
//
//    init(dict: [String:Any])
//    {
//        self.code = dict["code"] as? Int
//        self.message = dict["message"] as? String
//        let bodatdata = dict["body"] as? [String:Any]
//        self.body = Body12.init(dict: bodatdata!)
//
//    }
//}
// MARK: - AppointmentModel
struct AppointmentModel: Codable {
    let code: Int
    let message: String
    let body: Body12
}

// MARK: - Body
struct Body12: Codable {
    let slots: [Slot]?
    let leaves: [String]?
    let id, fromDate, toDate, startTime: String?
    let endTime, companyID: String?
    let status, createdAt: Int?
}

// MARK: - Slot
struct Slot: Codable {
    let slot, bookings: String?
}


//// MARK: - Body
//struct Body12
//{
//    var time = [String]()
//    var leave = [String]()
//    let id, serviceID, dayParts: String?
//    let status, createdAt: Int?
//    let service: Service12?
//
//    init(dict: [String:Any])
//    {
//        self.id = dict["id"] as? String
//        self.serviceID = dict["serviceID"] as? String
//        self.dayParts = dict["dayParts"] as? String
//        self.status = dict["status"] as? Int
//        let serviceData = dict["service"] as? [String:Any]
//        self.service = Service12.init(dict:serviceData!)
//        self.createdAt = dict["createdAt"] as? Int
//
//        if let arrtime = dict["time"] as? [String]{
//            for timeSlot in arrtime{
//                time.append(timeSlot)
//            }
//
//        }
//        if let arrtime = dict["leave"] as? [String]{
//            for timeSlot in arrtime{
//                leave.append(timeSlot)
//            }
//        }
//    }
//}
//
//// MARK: - Service
//struct Service12: Codable {
//    let icon, thumbnail: String?
//    let name, description: String?
//
//    init(dict:[String:Any]){
//        self.icon = dict["icon"] as? String
//        self.thumbnail = dict["thumbnail"] as? String
//        self.name = dict["name"] as? String
//        self.description = dict["description"] as? String
//    }
//}

//MARK:- CalendarModel
struct CalendarModel
{
    var date : String?
    var isSelected = false
    var isLeaveDay = false
    init(date:String?,isSelected:Bool?,isLeaveDay:Bool?) {
        self.date = date
        self.isSelected = isSelected ?? false
        self.isLeaveDay = isLeaveDay ?? false
        
    }
}

//MARK:- TimeSlotModel
struct TimeSlotModel
{
    var time : String?
    var isSelected = false
    init(time:String?,isSelected:Bool?) {
        self.time = time
        self.isSelected = isSelected ?? false
    }
}

