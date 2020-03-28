//
//  NotificationViewModel.swift
//  Fleet Management
//
//  Created by Atinder Kaur on 3/3/20.
//  Copyright © 2020 Seasia Infotech. All rights reserved.
//

import Foundation
import Foundation
import Alamofire

protocol NotificationVCDelegate
{
    func ShowResults(msg: String)
    func getData (model : [NotificationResult])
}

class NotificationListViewModel
{
    var delegate : NotificationVCDelegate
    var view : UIViewController
    
    init(Delegate : NotificationVCDelegate, view : UIViewController)
    {
        delegate = Delegate
        self.view = view
    }
    
  /*  func getNotificationList()
    {
        WebService.Shared.GetApi(url: APIAddress.GetNotificationList
           , Target: self.view, showLoader: true, completionResponse: { response in
            Commands.println(object: response)
            
            do
            {
                let jsonData = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                let model = try JSONDecoder().decode(NotificationResponseModel.self, from: jsonData)
                let list = model.data
                if list != nil {
                    self.delegate.getData(model: list!) }
                
         
            }
            catch
            {
                self.view.showAlertMessage(titleStr: kAppName, messageStr: kResponseNotCorrect)
            }
            
        }, completionnilResponse: {(error) in
            self.view.showAlertMessage(titleStr: kAppName, messageStr: error)
        })
        
    }
    
    
    func deleteNotificationList()
    {
        WebService.Shared.deleteApi(url: APIAddress.DeleteNotificationList
           , Target: self.view, showLoader: true, completionResponse: { response in
            Commands.println(object: response)
            
            
                    self.delegate.ShowResults(msg: "Notifications have been deleted successfully.")
          
           
        }, completionnilResponse: {(error) in
            self.view.showAlertMessage(titleStr: kAppName, messageStr: error)
        })
        
    }
    */
    
}
