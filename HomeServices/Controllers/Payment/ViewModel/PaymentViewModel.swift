//
//  PaymentViewModel.swift
//  HomeServices
//
//  Created by Navaldeep Kaur on 09/04/20.
//  Copyright © 2020 Atinder Kaur. All rights reserved.
//

import Foundation


protocol PaymentViewDelegate:class
{
    func Show(msg: String)
    func didError(error:String)
}

class PaymentViewModel
{
    //MARK:- Variables
    typealias successAddToCartHandler = (AddToCartModel) -> Void
    
    var delegate : PaymentViewDelegate
    var view : UIViewController
    
    init(Delegate : PaymentViewDelegate, view : UIViewController)
    {
        delegate = Delegate
        self.view = view
    }
    
    //MARK: - Create Order Api
    func createOrderApi(addressId:String?,serviceDateTime:String?,orderPrice:String?,promoCode:String?,completion: @escaping successAddToCartHandler)
    {
        let obj : [String:Any] = [
                                  "addressId" :addressId ?? "",
                                  "serviceDateTime":serviceDateTime ?? "",
                                  "orderPrice":orderPrice ?? "",
                                  "promoCode" :promoCode ?? ""]
        
        WebService.Shared.PostApi(url: APIAddress.createOrder, parameter: obj, Target: self.view, completionResponse: { (response) in
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
}

//MARK:- ViewDelegate
extension PaymentVC:PaymentViewDelegate{
    func Show(msg: String) {
        
    }
    
    func didError(error: String)
    {
     
    }
    
}




