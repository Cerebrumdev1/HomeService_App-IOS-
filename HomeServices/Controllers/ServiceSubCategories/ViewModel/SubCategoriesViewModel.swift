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
    //MARK:- Variables
    typealias successHandler = (SubCategoriesModel) -> Void
    typealias successDetailHandler = (ServiceDetailModel) -> Void
    typealias successAddToCartHandler = (AddToCartModel) -> Void
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
        WebService.Shared.GetApi(url: APIAddress.BASE_URL + APIAddress.getSubCategoriesList + (selectedId ?? "") , Target: self.view, showLoader: true, completionResponse: { (response) in
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
    
    //MARK:- GetSERVICE DETAIL
    
    func getServiceDetailApi(ServiceId:String?,completion: @escaping successDetailHandler)
    {
        WebService.Shared.GetApi(url: APIAddress.BASE_URL + APIAddress.getServiceDeatil + (ServiceId ?? "") , Target: self.view, showLoader: true, completionResponse: { (response) in
            print(response)
            do
            {
                let jsonData = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                let getAllListResponse = try JSONDecoder().decode(ServiceDetailModel.self, from: jsonData)
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
    //MARK:- AddToCart Api
    func addToCartApi(param:AddtoCartInputModel?,completion: @escaping successAddToCartHandler)
    {
        let obj : [String:Any] = [ApiParam.orderPrice:param?.orderPrice ?? "",ApiParam.orderTotalPrice :param?.orderTotalPrice ?? "",ApiParam.quantity:param?.quantity ?? "",ApiParam.serviceId:param?.serviceId ?? ""]
        
        WebService.Shared.PostApi(url: APIAddress.BASE_URL + APIAddress.addToCart, parameter: obj, Target: self.view, completionResponse: { (response) in
            do
            {
                let jsonData = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                let getAllListResponse = try JSONDecoder().decode(AddToCartModel.self, from: jsonData)
                completion(getAllListResponse)
            }
            catch
            {
                print(error.localizedDescription)
                self.view.showAlertMessage(titleStr: kAppName, messageStr: error.localizedDescription)
            }
        }, completionnilResponse: { (error) in
            self.view.showAlertMessage(titleStr: kAppName, messageStr: error)
        })
    }
    //MARK:- Validations
    func addToCartValidation(param:AddtoCartInputModel?)
    {
        
        if param?.quantity == "0"{
            delegate.Show(msg: alertMessages.selectQuantity)
        }
        else{
            addToCartApi(param: param, completion: { (responce) in
                print(responce)
                self.view.AlertMessageWithOkAction(titleStr: kAppName, messageStr: responce.message ?? "", Target: self.view) {
                    self.view.navigationController?.popViewController(animated: false)
                }
            })
        }
        
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
        self.lblNoRecord.isHidden = false
        self.tableViewSubCategoriesList.isHidden = true
    }
    
    
}
