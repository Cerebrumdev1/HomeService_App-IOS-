//
//  PromoCodevViewModel.swift
//  HomeServices
//
//  Created by Navaldeep Kaur on 08/04/20.
//  Copyright © 2020 Atinder Kaur. All rights reserved.
//

import Foundation


protocol PromoCodeViewDelegate:class
{
    func Show(msg: String)
    func didError(error:String)
}

class PromoCodeViewModel
{
    //MARK:- Variables
    typealias successHandler = (PromoCodeModel) -> Void
    typealias successAddToCartHandler = (ApplyCouponModel) -> Void
    
    var delegate : PromoCodeViewDelegate
    var view : UIViewController
    
    init(Delegate : PromoCodeViewDelegate, view : UIViewController)
    {
        delegate = Delegate
        self.view = view
    }
    //MARK:- PromoCodeListApi
        func getPromoCodeListApi(completion: @escaping successHandler)
        {
            WebService.Shared.GetApi(url: APIAddress.getPromoCodeList,Target: self.view, showLoader: true, completionResponse: { (response) in
                  print(response)
                        do
                        {
                            let jsonData = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                            let getAllListResponse = try JSONDecoder().decode(PromoCodeModel.self, from: jsonData)
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
    
    //MARK: - Apply Code Api
     func applyCouponApi(Id:String?,completion: @escaping successAddToCartHandler)
     {
         let obj : [String:Any] = [ApiParam.id:Id ?? ""]
         
        WebService.Shared.PostApi(url: APIAddress.applyCoupon, parameter: obj, Target: self.view, completionResponse: { (response) in
               do
                      {
                          let jsonData = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                          let getAllListResponse = try JSONDecoder().decode(ApplyCouponModel.self, from: jsonData)
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
extension ApplyPromoCodeVC : PromoCodeViewDelegate{
    func Show(msg: String) {
        
    }
    
    func didError(error: String)
    {
        self.lblNoRecord.isHidden = false
    }
    
}
