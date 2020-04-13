//
//  AppointmentViewModel.swift
//  HomeServices
//
//  Created by Navaldeep Kaur on 31/03/20.
//  Copyright © 2020 Atinder Kaur. All rights reserved.
//

import Foundation
import Alamofire

protocol AppointmentVCDelegate
{
    func getData (model : [AddressList_Result])
    func didError(error:String)
    func Show_results(msg: String)
    func addCarSuccess(msg:String)
}

class Appontment_ViewModel
{
    typealias sucessCartDetailHandler = (CartDetail) -> Void
    typealias successHandler = (AppointmentModel) -> Void
    typealias successAddToCartHandler = (AddToCartModel) -> Void
     typealias successCartHandler = (CartListingModel) -> Void
    
    var delegate : AppointmentVCDelegate
    var view : UIViewController
    
    init(Delegate : AppointmentVCDelegate, view : UIViewController)
    {
        delegate = Delegate
        self.view = view
    }
    
    //MARK:- Get Address List
    func getAddressList()
    {
        WebService.Shared.GetApi(url: APIAddress.GET_ADDRESS , Target: self.view, showLoader: false, completionResponse: { response in
            Commands.println(object: response)
            
            do
            {
                let jsonData = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                let model = try JSONDecoder().decode(AddressList_ResponseModel.self, from: jsonData)
                self.delegate.getData(model: model.body as! [AddressList_Result])
            }
            catch
            {
                self.view.showAlertMessage(titleStr: kAppName, messageStr: kResponseNotCorrect)
            }
            
        }, completionnilResponse: {(error) in
            // self.view.showAlertMessage(titleStr: kAppName, messageStr: error)
        })
        
    }
    
    //MARK:- CartDetailApi
    func getCartDetailApi(cartId:String?,completion: @escaping sucessCartDetailHandler)
    {
        WebService.Shared.GetApi(url: APIAddress.cartDetail + (cartId ?? "") , Target: self.view, showLoader: true, completionResponse: { (response) in
            print(response)
            do
            {
                let jsonData = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                let getAllListResponse = try JSONDecoder().decode(CartDetail.self, from: jsonData)
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
        let obj : [String:Any] = [ApiParam.addressId:param?.addressId ?? "",ApiParam.orderPrice:param?.orderPrice ?? "",ApiParam.orderTotalPrice :param?.orderTotalPrice ?? "",ApiParam.quantity:param?.quantity ?? "",ApiParam.serviceDateTime:param?.serviceDateTime ?? "",ApiParam.serviceId:param?.serviceId ?? ""]
        
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
    
    //MARK: - UpdateCart Api
    func upDateCartApi(param:AddtoCartInputModel?,cartId:String?,completion: @escaping successAddToCartHandler)
    {
        let obj : [String:Any] = [ApiParam.addressId:param?.addressId ?? "",ApiParam.orderPrice:param?.orderPrice ?? "",ApiParam.orderTotalPrice :param?.orderTotalPrice ?? "",ApiParam.quantity:param?.quantity ?? "",ApiParam.serviceDateTime:param?.serviceDateTime ?? "",ApiParam.serviceId:param?.serviceId ?? "",ApiParam.cartId:cartId ?? ""]
        
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
            self.view.showAlertMessage(titleStr: kAppName, messageStr: error)
        })
    }
    
    //MARK:- Get Schedule list
    func getSchedule(selectedDay:String?,selectedId:String?,completion: @escaping successHandler)
    {
        WebService.Shared.GetApi(url: APIAddress.Get_Schedule + (selectedId ?? "") + APIAddress.getScheduleParm + (selectedDay ?? ""), Target: self.view, showLoader: true, completionResponse: { (response) in
            print(response)
            if let responseData  = response as? [String : Any]
            {
                self.GetScheduleJSON(data: responseData, completionResponse: { (addedMember) in
                    completion(addedMember)
                }, completionError: { (error) in
                    
                })
            }
            else{
                
            }
            
        }, completionnilResponse: {(error) in
            self.delegate.didError(error: error)
        })
    }
    //MARK:- Validations
    func addToCartValidation(param:AddtoCartInputModel?,serviceDay:String?,serviceTime:String?)
    {
        guard let addressId = param?.addressId,  !addressId.isEmpty, !addressId.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else
        {
            delegate.Show_results(msg: alertMessages.selectAddress)
            return
        }
        guard let service_Day = serviceDay,!service_Day.isEmpty, !service_Day.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else
        {
            delegate.Show_results(msg: alertMessages.selectDay)
            return
        }
        guard let service_Time = serviceTime,!service_Time.isEmpty, !service_Time.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else
        {
            delegate.Show_results(msg:alertMessages.selectTime)
            return
        }
        
        addToCartApi(param: param, completion: { (responce) in
            print(responce)
            self.delegate.addCarSuccess(msg:  responce.message ?? "")
        })
    }
    
    //updateCart
    
    func updateToCartValidation(param:AddtoCartInputModel?,serviceDay:String?,serviceTime:String?,cartId:String?)
       {
           guard let addressId = param?.addressId,  !addressId.isEmpty, !addressId.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else
           {
               delegate.Show_results(msg: alertMessages.selectAddress)
               return
           }
           guard let service_Day = serviceDay,!service_Day.isEmpty, !service_Day.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else
           {
               delegate.Show_results(msg: alertMessages.selectDay)
               return
           }
           guard let service_Time = serviceTime,!service_Time.isEmpty, !service_Time.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else
           {
               delegate.Show_results(msg:alertMessages.selectTime)
               return
           }
           
           upDateCartApi(param: param, cartId: cartId, completion: { (responce) in
               print(responce)
               self.delegate.addCarSuccess(msg:  responce.message ?? "")
           })
       }
    //MARK:- CartListApi
     func getCartListApi(completion: @escaping successCartHandler)
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
            // self.delegate.didError(error: error)
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
    
    //MARK:- GetScheduleJSON
    private func GetScheduleJSON(data: [String : Any],completionResponse:  @escaping (AppointmentModel) -> Void,completionError: @escaping (String?) -> Void)
    {
        let addedMembersData = AppointmentModel(dict: data)
        completionResponse(addedMembersData)
        
    }
}
