//
//  NotificationModel.swift
//  Fleet Management
//
//  Created by Atinder Kaur on 3/3/20.
//  Copyright © 2020 Seasia Infotech. All rights reserved.
//

import Foundation
struct NotificationResponseModel: Decodable
{
    var code: Int?
    var message : String?
    var data :  [NotificationResult]?
}

struct NotificationResult: Decodable
{
    var notification_id : Int?
    var notification_title :String?
    var notification_description :String?
    var user_id :String?
    var user_type :String?
    var created_at :String?
    var updated_at :String?
   

}
