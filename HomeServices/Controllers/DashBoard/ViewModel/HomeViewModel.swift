//
//  SubCategoriesViewModel.swift
//  Fleet Management
//
//  Created by Navaldeep Kaur on 25/03/20.
//  Copyright © 2020 Seasia Infotech. All rights reserved.

import Foundation
import Alamofire

protocol HomeServiceDelegate:class
{
    func Show(msg: String)
    func didError(error:String)
}

class HomeViewModel
{
    typealias successHandler = (HomeModel) -> Void
    var delegate : HomeServiceDelegate
    var view : UIViewController
    
    init(Delegate : HomeServiceDelegate, view : UIViewController)
    {
        delegate = Delegate
        self.view = view
    }

    //MARK:- GetHomeServiceApi
        func getHomeServicesApi(completion: @escaping successHandler)
        {
            WebService.Shared.GetApi(url: APIAddress.BASE_URL + APIAddress.getServiceCategories , Target: self.view, showLoader: true, completionResponse: { (response) in
                  print(response)
                        do
                        {
                            let jsonData = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                            let getAllListResponse = try JSONDecoder().decode(HomeModel.self, from: jsonData)
                            completion(getAllListResponse)
                        }
                        catch
                        {
                            print(error.localizedDescription)
                            self.view.showAlertMessage(titleStr: kAppName, messageStr: error.localizedDescription)
                        }
                        
                    }, completionnilResponse: {(error) in
                        self.delegate.didError(error: error)
                    })
        }

    func jsonToString(json: [String:Any]) -> String
    {
        do
        {
            let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
            let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
            print(convertedString ?? "defaultvalue")
            return convertedString ?? ""
        }
        catch let myJSONError
        {
            print(myJSONError)
            return ""
        }
        
    }
}

//MARK:- HomeDelegate
extension HomeVC : HomeServiceDelegate
{
    func Show(msg: String) {
        
    }
    
    func didError(error: String) {
        
    }
    
    
}
