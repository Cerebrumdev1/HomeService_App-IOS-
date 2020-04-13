//
//  PaymentVC.swift
//  HomeServices
//
//  Created by Navaldeep Kaur on 03/04/20.
//  Copyright © 2020 Atinder Kaur. All rights reserved.
//

import UIKit

class PaymentVC: UIViewController {
    
    //MARK:- Outlet and Variables
    @IBOutlet weak var lblServiceName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var btnProceed: CustomButton!
    @IBOutlet weak var lblTotalPrice: UILabel!
    
    var viewModel : PaymentViewModel?
    var cartList : CartListingModel.Body?
    var addressId : String?
    var promoCode : String?
    
    //MARK:- lifeCycleMethods
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    //MARK:- Other functions
    func setView(){
        
        viewModel = PaymentViewModel.init(Delegate: self, view: self)
        //setColor
        btnProceed.backgroundColor = Appcolor.kTheme_Color
        btnProceed.setTitleColor(Appcolor.kTextColorBlack, for: .normal)
        
        //setData
        lblServiceName.text = cartList?.data[0].service?.name
        lblDiscount.text = "\(cartList?.discount ?? 0) %"
        lblDate.text = cartList?.data[0].serviceDateTime
        lblTotalPrice.text = "$ \(cartList?.sum ?? 0)"
    }
    
    //MARK:- HitApi
    
    //createOrderApi
    func createOrderApi()
    {
        viewModel?.createOrderApi(serviceId: cartList?.data[0].service?.id, addressId: addressId, serviceDateTime: "2020-04-11 14:00:00", orderPrice: "\(cartList?.sum ?? 0)", serviceCharges: "", promoCode: promoCode, completion: { (responce) in
            self.AlertMessageWithOkAction(titleStr: kAppName, messageStr: responce.message ?? "", Target: self)
            {
             let controller = Navigation.GetInstance(of: .SuccessVC) as! SuccessVC
             self.push_To_Controller(from_controller: self, to_Controller: controller)
            }
        })
    }
    //MARK:- Actions
    @IBAction func backAction(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func proceedACtion(_ sender: Any)
    {
        createOrderApi()
    }
}
