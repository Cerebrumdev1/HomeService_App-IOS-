//
//  OrderListVC.swift
//  HomeServices
//
//  Created by Navaldeep Kaur on 31/03/20.
//  Copyright © 2020 Atinder Kaur. All rights reserved.
//

import UIKit

//MARK:- Delegate
protocol CartListDelegate:class
{
    func removeFromCart(index:Int?)
    func updateCart(index:Int?)
}

class OrderListVC: UIViewController {
    
    //MARK:- Outlet and Variables
    @IBOutlet weak var tableViewOrder: UITableView!
    @IBOutlet weak var lblItemCount: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnCheckOut: CustomButton!
    @IBOutlet weak var lblNoRecord: UILabel!
    @IBOutlet weak var btnAddMoreService: CustomButton!
    
    var viewModel : OrderViewModel?
    var cartList = [CartListingModel.Datum]()
    var isFromSubCategoriesList : Bool?
    var row = 0
    
    //MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK:- Other functions
    func setView()
    {
        viewModel = OrderViewModel.init(Delegate: self, view: self)
        tableViewOrder.delegate = self
        tableViewOrder.dataSource = self
        tableViewOrder.separatorStyle = .none
        if isFromSubCategoriesList == true
        {
            btnAddMoreService.isHidden = false
        }
        else{
            btnAddMoreService.isHidden = true
        }
        
        //setColor
        btnAddMoreService.backgroundColor = Appcolor.kTheme_Color
        btnCheckOut.backgroundColor = Appcolor.kTheme_Color
        
        getCartList()
    }
    
    //MARK:- HitApi
    func getCartList()
    {
        viewModel?.getCartListApi(completion: { (responce) in
            print(responce)
            if let cartListData = responce.body?.data{
                if cartListData.count > 0
                {
                    self.cartList = cartListData
                    self.lblNoRecord.isHidden = true
                    self.tableViewOrder.isHidden = false
                    self.tableViewOrder.reloadData()
                    
                    //setData
                    self.lblItemCount.text = "Items ( \(responce.body?.totalQunatity ?? 0) )"
                    self.lblPrice.text = "$ \(responce.body?.sum ?? 0)"
                    self.lblTotalPrice.text = "$ \(responce.body?.sum ?? 0)"
                }
                else{
                    self.lblNoRecord.isHidden = false
                    self.tableViewOrder.isHidden = true
                }
            }
            
        })
    }
    
    
    //MARK:- Actions
    @IBAction func applyCouponAction(_ sender: Any)
    {
        let controller = Navigation.GetInstance(of: .ApplyPromoCodeVC) as! ApplyPromoCodeVC
        self.present_To_Controller(from_controller: self, to_Controller: controller)
    }
    @IBAction func addMoreServiceAction(_ sender: Any) {
        
        if (self.navigationController != nil) {
            for vc in  self.navigationController!.viewControllers
            {
                if vc is SubCategoriesListVC {
                    self.navigationController?.popToViewController(vc, animated: false)
                }
            }
        }
    }
    @IBAction func CheckOutAction(_ sender: Any)
    {
        let controller = Navigation.GetInstance(of: .PaymentVC) as! PaymentVC
        self.push_To_Controller(from_controller: self, to_Controller: controller)
    }
    
    @IBAction func BackAction(_ sender: Any) {
        // self.navigationController?.popViewController(animated: false)
        
        if isFromSubCategoriesList == true{
            if (self.navigationController != nil) {
                for vc in  self.navigationController!.viewControllers
                {
                    if vc is SubCategoriesListVC {
                        self.navigationController?.popToViewController(vc, animated: false)
                    }
                }
            }
        }
        else{
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
    //MARK:- DeleteRow
    func deleteCellROW()
       {
           let indxpth = IndexPath(row: self.row, section: 0)
        cartList.remove(at: self.row)
           self.tableViewOrder.deleteRows(at: [indxpth], with: .fade)
           DispatchQueue.main.asyncAfter(deadline: .now() + 1.0)
           {
            if (self.cartList.count == 0)
               {
                  self.tableViewOrder.isHidden = true
                  self.lblNoRecord.isHidden = false
               }
            else{
                self.tableViewOrder.isHidden = false
                self.lblNoRecord.isHidden = true
            }
               self.tableViewOrder.reloadData()
           }
           
           
       }
}

//MARK:- TableView DelegateAnd DataSource
extension OrderListVC : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return cartList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let cell = tableView.dequeueReusableCell(withIdentifier: HomeIdentifiers.OrderListCell, for: indexPath) as? OrderListCell
        {
            cell.btnDelete.tag = indexPath.row
            cell.btnUpdate.tag = indexPath.row
            cell.viewDelegate = self
            cell.setView(data:cartList[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
}


//MARK:- CartDeleGate
extension OrderListVC:CartListDelegate
{
    func updateCart(index: Int?)
    {
        let vc = UIStoryboard.init(name: kStoryBoard.appointment, bundle: nil).instantiateViewController(withIdentifier: AppointmentDetailIdentifiers.AppointmentDetailVC) as! AppointmentDetailVC
               vc.updateCartId = self.cartList[index ?? 0].id
               vc.isEdited = true
              // vc.serviceDetail = self.serviceDetail
               //vc.isFromSubCategoriesList = isFromSubCategoriesList
               self.navigationController?.pushViewController(vc,animated:false)
    }
    
    func removeFromCart(index: Int?) {
        self.AlertMessageWithOkCancelAction(titleStr: kAppName, messageStr: "Do you want to delete this cart?", Target: self)
        { (actn) in
            if (actn == KYes)
            {
                self.row = index ?? 0
                self.viewModel?.removeFromCartApi(cartId: self.cartList[index ?? 0].id, completion: { (responce) in
                    self.AlertMessageWithOkAction(titleStr: kAppName, messageStr: responce.message ?? "", Target: self)
                        {
                                 //   self.deleteCellROW()
                            self.getCartList()
                         }
                })
            }
        }
    }
    
    
}
