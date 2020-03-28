//
//  SubCategoriesViewModel.swift
//  Fleet Management
//
//  Created by Navaldeep Kaur on 25/03/20.
//  Copyright © 2020 Seasia Infotech. All rights reserved.
//

import Foundation
import Alamofire

protocol SubCategoriesDelegate:class
{
    func Show(msg: String)
    func didError(error:String)
}

class SubCategoriesViewModel
{
    typealias successHandler = (SubCategoriesModel) -> Void
    var delegate : SubCategoriesDelegate
    var view : UIViewController
    
    init(Delegate : SubCategoriesDelegate, view : UIViewController)
    {
        delegate = Delegate
        self.view = view
    }

    //MARK:- GetSubCategoriesServiceApi
        func getSubCategoriesListApi(selectedId:String?,completion: @escaping successHandler)
        {
            WebService.Shared.GetApi(url: HomeServiceApi.BASE_URL + HomeServiceApi.getSubCategoriesList + (selectedId ?? "") , Target: self.view, showLoader: true, completionResponse: { (response) in
                  print(response)
                        do
                        {
                            let jsonData = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                            let getAllListResponse = try JSONDecoder().decode(SubCategoriesModel.self, from: jsonData)
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

//MARK:- SubCategoriesDelegate
extension SubCategoriesListVC : SubCategoriesDelegate
{
    func Show(msg: String) {
        
    }
    func didError(error: String) {
        
    }
    
    
}
