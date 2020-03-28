//
//  SettingVC.swift
//  HomeServices
//
//  Created by Navaldeep Kaur on 27/03/20.
//  Copyright © 2020 Atinder Kaur. All rights reserved.
//

import UIKit

class SettingVC: CustomController {

    //MARK:- OUTLET and VARIABLES
    @IBOutlet weak var lblPhoneNo: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    @IBOutlet weak var btnMenu: UIBarButtonItem!
    @IBOutlet weak var lblErrorMessage: UILabel!
    @IBOutlet weak var lblMoney: UILabel!
    //MARK:- lifeCycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setView()
    }
   
    //MARK:- Other Functions
    func setView()
    {
        btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.setTapGestureOnSWRevealontroller(view: self.view, controller: self)
        
    }
    
    //MARK:- Actions
    @IBAction func AccountSettingAction(_ sender: Any) {
    }
    @IBAction func AddAddressAction(_ sender: Any) {
    }
    @IBAction func InviteAndEranAction(_ sender: Any) {
    }
    @IBAction func writeAsAction(_ sender: Any) {
    }
    
    @IBAction func RateUsAction(_ sender: Any) {
    }
    
    @IBAction func TabBarActions(_ sender: Any) {
        switch (sender as AnyObject).tag {
               case 0:
                   let controller = Navigation.GetInstance(of: .HomeVC) as! HomeVC
                   let frontVC = revealViewController().frontViewController as? UINavigationController
                   frontVC?.pushViewController(controller, animated: false)
                   revealViewController().pushFrontViewController(frontVC, animated: true)
                   break
               case 1:
                 
                   break
               case 2:
                   let controller = Navigation.GetInstance(of: .SettingVC) as! SettingVC
                   let frontVC = revealViewController().frontViewController as? UINavigationController
                   frontVC?.pushViewController(controller, animated: false)
                   revealViewController().pushFrontViewController(frontVC, animated: true)
                   break
               default:
                  break
               }
           }
    }
    
