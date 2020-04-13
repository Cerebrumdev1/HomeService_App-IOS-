//
//  OrderViewModel.swift
//  HomeServices
//
//  Created by Navaldeep Kaur on 02/04/20.
//  Copyright © 2020 Atinder Kaur. All rights reserved.
//


import Foundation


protocol CreatedOrderViewDelegate:class
{
    func Show(msg: String)
    func didError(error:String)
}

//MARK:- OrderListViewModel
class CreatedOrderViewModel
{
    //MARK:- Variables
    typealias successHandler = (OrderModel) -> Void
    typealias successAddToCartHandler = (AddToCartModel) -> Void
    
    var delegate : CreatedOrderViewDelegate
    var view : UIViewController
    
    init(Delegate : CreatedOrderViewDelegate, view : UIViewController)
    {
        delegate = Delegate
        self.view = view
    }
    //MARK:- CartListApi
    func getOrderList(progressStatus:Int?,page:Int?,limit:Int?,completion: @escaping successHandler)
    {
        let url = APIAddress.orderList +
            "\(progressStatus ?? 0)" + APIAddress.page + "\(page ?? 0)"
        
        WebService.Shared.GetApi(url: url + APIAddress.limit + "\(limit ?? 0)",Target: self.view, showLoader: true, completionResponse: { (response) in
            print(response)
            do
            {
                let jsonData = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                let getAllListResponse = try JSONDecoder().decode(OrderModel.self, from: jsonData)
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
    
    //MARK:- RemoveOrder Api
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
extension CreatedOrderListVC:CreatedOrderViewDelegate{
    func Show(msg: String) {
        
    }
    
    func didError(error: String)
    {
           }
    
}
