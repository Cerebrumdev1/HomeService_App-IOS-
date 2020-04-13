//
//  SuccessVC.swift
//  HomeServices
//
//  Created by Navaldeep Kaur on 08/04/20.
//  Copyright © 2020 Atinder Kaur. All rights reserved.
//

import UIKit

class SuccessVC: UIViewController {
    
    //MARK:- Outlet and Variables
    @IBOutlet weak var btnBack: CustomButton!
    
    //MARK:- life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        
    }
    
    //MARK:- other functions
    func setView()
    {
        self.hideNAV_BAR(controller: self)
        //setColor
        btnBack.backgroundColor = AppButtonColor.kBlueColor
        btnBack.setTitleColor(Appcolor.kTextColorWhite, for: .normal)
    }
    //MARK:- Actions
    @IBAction func backAction(_ sender: Any)
    {
        if (self.navigationController != nil) {
            for vc in  self.navigationController!.viewControllers
            {
                if vc is HomeVC {
                    self.navigationController?.popToViewController(vc, animated: false)
                }
            }
        }
    }
}
