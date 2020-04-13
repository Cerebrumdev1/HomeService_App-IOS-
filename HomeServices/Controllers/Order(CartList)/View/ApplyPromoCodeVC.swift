//
//  ApplyPromoCodeVC.swift
//  HomeServices
//
//  Created by Navaldeep Kaur on 06/04/20.
//  Copyright © 2020 Atinder Kaur. All rights reserved.
//

import UIKit

//MARK:- ViewDelegate
protocol ApplyPromoCodeDelegate
{
    func applyCode(index:Int?)
}

class ApplyPromoCodeVC: UIViewController {

    //MARK:- Outlet and Variables
    
    @IBOutlet weak var lblNoRecord: UILabel!
    @IBOutlet weak var txtPromoCode: UITextField!
    @IBOutlet weak var btnApplyCode: CustomButton!
    @IBOutlet weak var tableViewPromoCode: UITableView!
    
    var viewModel : PromoCodeViewModel?
    var promoCodeList = [PromoCodeModel.Body]()
     var viewDelegate : CartListDelegate?
    
    //MARK:- lifeCycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
   
    //MARK:- Actions
    @IBAction func applyManualPromoCode(_ sender: Any)
    {
        if (txtPromoCode.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)! {
            showAlertMessage(titleStr: kAppName, messageStr: alertMessages.enterPromoCode )
        }
        else{
            applyCouponApi(id: txtPromoCode.text)
        }
        
    }
    
    //MARK:- Other functions
    func setView()
    {
           viewModel = PromoCodeViewModel.init(Delegate: self, view: self)
           tableViewPromoCode.delegate = self
           tableViewPromoCode.dataSource = self
           tableViewPromoCode.separatorStyle = .none
        //Api
        getPromoCodeList()
    }

    //MARK:- Hit Api
    func getPromoCodeList(){
        viewModel?.getPromoCodeListApi(completion: { (responce) in
            print(responce)
            if let data = responce.body{
                if(data.count > 0){
                    self.promoCodeList = data
                    self.tableViewPromoCode.isHidden = false
                    self.lblNoRecord.isHidden = true
                    self.tableViewPromoCode.reloadData()
                }
                else{
                   // self.tableViewPromoCode.isHidden = true
                    self.lblNoRecord.isHidden = false
                }
            }
        })
    }
    
    func applyCouponApi(id: String?){
        viewModel?.applyCouponApi(Id: id, completion: { (responce) in
            self.AlertMessageWithOkAction(titleStr: kAppName, messageStr: responce.message ?? "", Target: self) {
                if let data = responce.body
                {
                self.viewDelegate?.callBack(data:data)
                }
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
    
}

//MARK:- TableView DelegateAnd DataSource
extension ApplyPromoCodeVC : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return promoCodeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let cell = tableView.dequeueReusableCell(withIdentifier: HomeIdentifiers.PromoCodeCell, for: indexPath) as? PromoCodeCell
        {
            cell.btnApply.tag = indexPath.row
            cell.viewDelegate = self
           // cell.viewCodeBack.addDashedBorder()
            cell.setData(data:promoCodeList[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
}

//MARK:- View Delegate

extension ApplyPromoCodeVC : ApplyPromoCodeDelegate
{
    func applyCode(index: Int?)
    {
        applyCouponApi(id: promoCodeList[index ?? 0].code)
    }

}
