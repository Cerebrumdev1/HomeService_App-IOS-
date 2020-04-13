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
    func updateCarSuccess(msg: String)
}

//MARK:- CartListViewModel
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
    
    //MARK:- RemoveFromCart Api
    func removeCouponApi(Id:String?,completion: @escaping successAddToCartHandler)
    {
        let obj : [String:Any] = [ApiParam.id:Id ?? ""]
        
        WebService.Shared.PostApi(url: APIAddress.removeCoupon, parameter: obj, Target:  self.view, completionResponse: { (response) in
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
    
   //MARK: - UpdateCart Api
   func upDateCartApi(param:AddtoCartInputModel?,cartId:String?,completion: @escaping successAddToCartHandler)
   {
       let obj : [String:Any] = [ApiParam.orderPrice:param?.orderPrice ?? "",ApiParam.orderTotalPrice :param?.orderTotalPrice ?? "",ApiParam.quantity:param?.quantity ?? "",ApiParam.serviceId:param?.serviceId ?? "",ApiParam.cartId:cartId ?? ""]
       
       WebService.Shared.PutApi(url: APIAddress.updateCart, parameter: obj, Target:  self.view, completionResponse: { (response) in
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
          // self.view.showAlertMessage(titleStr: kAppName, messageStr: error)
       })
   }
  
    //MARK:- Validations
    func updateToCartValidation(param:AddtoCartInputModel?,cartId:String?)
       {
            if param?.quantity == "0"
            {
                     delegate.Show(msg: alertMessages.selectQuantity)
            }
           upDateCartApi(param: param, cartId: cartId, completion: { (responce) in
               print(responce)
               self.delegate.updateCarSuccess(msg:  responce.message ?? "")
           })
       }
}

//MARK:- ViewDelegate
extension OrderListVC:OrderViewDelegate{
    func updateCarSuccess(msg: String) {
        getCartList()
    }
    
    func Show(msg: String) {
        showAlertMessage(titleStr: kAppName, messageStr: msg)
    }
    
    func didError(error: String)
    {
        self.lblNoRecord.isHidden = false
        self.tableViewOrder.isHidden = true
        self.viewButtons.isHidden = true
        self.viewTotalPrice.isHidden = true
    }
    
}
