//
//  NotificationVC.swift
//  Fleet Management
//
//  Created by Atinder Kaur on 3/3/20.
//  Copyright © 2020 Seasia Infotech. All rights reserved.
//

import UIKit

class NotificationVC: CustomController {
    
    var viewModel:NotificationListViewModel?
    var localModel : [NotificationResult]?
    @IBOutlet weak var tblViewNotificationList: UITableView!
    @IBOutlet weak var btnDrawer: UIBarButtonItem!
    @IBOutlet weak var btnNotification: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        fetchNotifications()
        tblViewNotificationList.reloadData()
        // Do any additional setup after loading the view.
    }
    
    func setUpView() {
        self.title = "NOTIFICATIONS"
        tblViewNotificationList.tableFooterView = UIView()
        self.viewModel = NotificationListViewModel.init(Delegate: self, view: self)
        btnDrawer.target = self.revealViewController()
              btnDrawer.action = #selector(SWRevealViewController.revealToggle(_:))
              self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
              self.setTapGestureOnSWRevealontroller(view: self.view, controller: self)
        
    }
    
    func fetchNotifications() {
       //  self.viewModel?.getNotificationList()
    }
    
    
    @IBAction func actionTrashIcon(_ sender: UIBarButtonItem) {
        // self.viewModel?.deleteNotificationList()
        
    }
    
}


extension NotificationVC : UITableViewDelegate, UITableViewDataSource
     {
         
         func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
         {
             return 5
         }
         
         func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
         {
             let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell")as! NotificationCell
            if (localModel != nil) {
                             let obj = localModel![indexPath.row]
                cell.lblTitle.text = "Notification Alert"
                cell.llblDescription.text = "Your assigned service has completed bu Amanpreet."
                
            }
             return cell
         }
         
         func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
         {
             
         }
         
         func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
         {
                 return 86.0
         }
         
         // Set the spacing between sections
         func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
             return 15
         }
         
         // Make the background color show through
            func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
                let headerView = UIView()
                headerView.backgroundColor = UIColor.clear
                return headerView
            }
     }



extension NotificationVC : NotificationVCDelegate
{
    func ShowResults(msg: String) {
        self.showAlertMessage(titleStr: kAppName, messageStr: msg)
        // self.viewModel?.getNotificationList()
    }
    
    func getData(model: [NotificationResult]) {
        if model.count > 0 {
            localModel = model
            tblViewNotificationList.reloadData()
        }
    }
    
   
}
