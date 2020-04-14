//
//  PaymentVC.swift
//  HomeServices
//
//  Created by Navaldeep Kaur on 03/04/20.
//  Copyright © 2020 Atinder Kaur. All rights reserved.
//

import UIKit
import PayUMoneyCoreSDK
import PlugNPlay
import CryptoSwift

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
    var serviceDateTime : String?
    
    var totalItems = 0
    var payPrice = "0"
    var addrssID = ""
    var merchantKey = "n01WMWPL"//"7001862"
    var salt = "cBQg9So9fV"//"hlAIVpWKGy"
    var PayUBaseUrl = "https://test.payu.in"
    
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
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d yyyy"
        let result = formatter.string(from: date)
        
        //setData
        lblServiceName.text = cartList?.data[0].service?.name
        lblDiscount.text = "\(cartList?.discount ?? 0) %"
        lblDate.text = result
        lblTotalPrice.text = "$ \(cartList?.sum ?? 0)"
    }
    
    func makePayment()
     {
         let trscnID = self.generateRandomString()
         PlugNPlay .setMerchantDisplayName("Payment")
         
         //Customize UI of PayuMoney
         
         PlugNPlay .setButtonTextColor(UIColor.white)
         PlugNPlay .setButtonColor(Appcolor.kTheme_Color)
         PlugNPlay .setTopTitleTextColor(UIColor.white)
         PlugNPlay .setTopBarColor(Appcolor.kTheme_Color)
         PlugNPlay .setDisableCompletionScreen(true)
         PlugNPlay.setExitAlertOnBankPageDisabled(true)
         PlugNPlay.setExitAlertOnCheckoutPageDisabled(true)
         
         let txnParam = PUMTxnParam()
         txnParam.phone = "8872227506"//"9992364445"
         txnParam.email = "cerebrumdev3@gmail.com"
         // txnParam.amount = self.couponDetails?.payableAmount
         txnParam.amount = "1"
         // txnParam.environment = PUMEnvironment.test
         txnParam.environment = PUMEnvironment.production
         txnParam.firstname = "Tushal"//"Salon App"
         txnParam.key = "vnlMA5F0"
         txnParam.merchantid = "7001862"
         txnParam.txnID = trscnID
         txnParam.surl = "https://www.payumoney.com/mobileapp/payumoney/success.php"
         txnParam.furl = "https://www.payumoney.com/mobileapp/payumoney/failure.php"
         txnParam.productInfo = "Salon App"
         txnParam.udf1 = "as"
         txnParam.udf2 = "sad"
         txnParam.udf3 = "ud3"
         txnParam.udf4 = ""
         txnParam.udf5 = ""
         txnParam.udf6 = ""
         txnParam.udf7 = ""
         txnParam.udf8 = ""
         txnParam.udf9 = ""
         txnParam.udf10 = ""
         
         
         let hashSequence = "\(txnParam.key!)|\(txnParam.txnID!)|\(txnParam.amount!)|\(txnParam.productInfo! )|\(txnParam.firstname!)|\(txnParam.email!)|\(txnParam.udf1!)|\(txnParam.udf2!)|\(txnParam.udf3!)|\(txnParam.udf4!)|\(txnParam.udf5!)|\(txnParam.udf6!)|\(txnParam.udf7!)|\(txnParam.udf8!)|\(txnParam.udf9!)|\(txnParam.udf10!)|\(salt)"
         
         let data = hashSequence.data(using: .utf8)
         
         txnParam.hashValue = data?.sha512().toHexString()
         
         
         PlugNPlay.presentPaymentViewController(withTxnParams: txnParam, on: self)
         { (response, error, extraParam) in
             
             
             if (response != nil)
             {
                 if let dict : Dictionary = response
                 {
                     print(dict)
                     
                     let result = dict["result"]as? NSDictionary
                     let status  = result?.value(forKey: "status")as? String
                     
                     if (status == "success")
                     {
                         self.createOrderApi()//creating order after payment successfull
                     }
                     else
                     {
                         let reason = self.get_transaction_failed_reason(dicnry: result ?? NSDictionary())
                         self.showAlertMessage(titleStr: kAppName, messageStr: reason)
                     }
                 }
                 else
                 {
                     self.showAlertMessage(titleStr: kAppName, messageStr: kSomthingWrong)
                 }
             }
             else
             {
                 self.showAlertMessage(titleStr: "Sorry", messageStr: error?.localizedDescription ?? "Payment failed!")
             }
             
             print(error?.localizedDescription as Any)
         }
         
     }
    
    //MARK:- HitApi
    
    //createOrderApi
    func createOrderApi()
    {
        viewModel?.createOrderApi(addressId: addressId, serviceDateTime: serviceDateTime, orderPrice: "\(cartList?.sum ?? 0)", promoCode: promoCode, completion: { (responce) in
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
        self.makePayment()
//       let controller = Navigation.GetInstance(of: .SuccessVC) as! SuccessVC
//                      self.push_To_Controller(from_controller: self, to_Controller: controller)
    }
}
