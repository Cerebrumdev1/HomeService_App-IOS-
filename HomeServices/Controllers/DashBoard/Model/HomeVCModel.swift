// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - HomeModel
struct HomeModel: Codable
{
    let code: Int?
    let message: String?
    let body: Body?
    
    // MARK: - Body
internal struct Body: Codable {
        let banners: [Banner]?
        let trendingServices: [TrendingService]?
        let services: [Service]?
    }
}



// MARK: - Banner
struct Banner: Codable {
    let name: String?
    let url: String?
}

// MARK: - Service
struct Service: Codable {
    let id: String?
    let name: String?
    let icon: String?
}

// MARK: - TrendingService
struct TrendingService: Codable {
    let id: String?
    let name: String?
    let icon: String?
}

//MARK:- Customize Service

struct OtherServices
{
    var id: String?
    var name: String?
    var icon: String?
    var isSelected = false
    
    init(dict: [String:Any])
    {
     self.id = dict["id"] as? String
     self.name = dict["name"] as? String
     self.icon = dict["icon"] as? String
     self.isSelected = (dict["isSelected"] != nil)
     }
}


