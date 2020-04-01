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
}

class Appontment_ViewModel
{
    typealias successHandler = (AppointmentModel) -> Void
    var delegate : AppointmentVCDelegate
    var view : UIViewController
    
    init(Delegate : AppointmentVCDelegate, view : UIViewController)
    {
        delegate = Delegate
        self.view = view
    }
    
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
            self.view.showAlertMessage(titleStr: kAppName, messageStr: error)
        })
        
    }
    
      func getSchedule()
      {
          WebService.Shared.GetApi(url: APIAddress.Get_Schedule , Target: self.view, showLoader: false, completionResponse: { response in
              Commands.println(object: response)
              
              do
              {
                  let jsonData = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                  let model = try JSONDecoder().decode(AppointmentModel.self, from: jsonData)
                  self.delegate.getData(model: model.body as! [AddressList_Result])
              }
              catch
              {
                  self.view.showAlertMessage(titleStr: kAppName, messageStr: kResponseNotCorrect)
              }
              
          }, completionnilResponse: {(error) in
              self.view.showAlertMessage(titleStr: kAppName, messageStr: error)
          })
          
      }
    
    func getSchedule(selectedDay:String?,selectedId:String?,completion: @escaping successHandler)
           {
            WebService.Shared.GetApi(url: APIAddress.Get_Schedule + (selectedId ?? ""), Target: self.view, showLoader: true, completionResponse: { (response) in
                     print(response)
                           do
                           {
                               let jsonData = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                               let getAllListResponse = try JSONDecoder().decode(AppointmentModel.self, from: jsonData)
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
}
