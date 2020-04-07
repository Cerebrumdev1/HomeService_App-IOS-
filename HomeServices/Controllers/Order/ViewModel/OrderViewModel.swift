//
//  OrderViewModel.swift
//  HomeServices
//
//  Created by Navaldeep Kaur on 02/04/20.
//  Copyright © 2020 Atinder Kaur. All rights reserved.
//


import Foundation


protocol OrderViewDelegate:class
{
    func Show(msg: String)
    func didError(error:String)
}

class OrderViewModel
{
    //MARK:- Variables
    typealias successHandler = (CartListingModel) -> Void
    typealias successAddToCartHandler = (AddToCartModel) -> Void
    
    var delegate : OrderViewDelegate
    var view : UIViewController
    
    init(Delegate : OrderViewDelegate, view : UIViewController)
    {
        delegate = Delegate
        self.view = view
    }

    //MARK:- CartListApi
        func getCartListApi(completion: @escaping successHandler)
        {
            WebService.Shared.GetApi(url: APIAddress.getCartList,Target: self.view, showLoader: true, completionResponse: { (response) in
                  print(response)
                        do
                        {
                            let jsonData = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                            let getAllListResponse = try JSONDecoder().decode(CartListingModel.self, from: jsonData)
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
    
    //MARK:- RemoveFromCart Api
    func removeFromCartApi(cartId:String?,completion: @escaping successAddToCartHandler)
      {
        let obj : [String:Any] = ["cartId":cartId ?? ""]
        WebService.Shared.deleteApi(url: APIAddress.deleteToCart + (cartId ?? ""), parameter: obj, Target: self.view, showLoader: true, completionResponse: { (responce) in
              do
                        {
                            let jsonData = try JSONSerialization.data(withJSONObject: responce, options: .prettyPrinted)
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
extension OrderListVC:OrderViewDelegate{
    func Show(msg: String) {
        
    }
    
    func didError(error: String)
    {
        
    }
    
}
