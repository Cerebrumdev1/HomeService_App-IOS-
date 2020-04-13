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
    func updateCart(index:Int?,stepperValue:String?,totalPrice:String?)
    func callBack(data:ApplyCouponModel.Body)
}

class OrderListVC: UIViewController {
    
    //MARK:- Outlet and Variables
    @IBOutlet weak var viewButtons: UIStackView!
    @IBOutlet weak var kOldlPriceWidth: NSLayoutConstraint!
    @IBOutlet weak var tableViewOrder: UITableView!
    @IBOutlet weak var viewTotalPrice: CustomUIView!
    @IBOutlet weak var imageArrow: UIImageView!
    @IBOutlet weak var lblOldPrice: UILabel!
    @IBOutlet weak var kRemoveButtonWidth: NSLayoutConstraint!
    @IBOutlet weak var btnApplyCoupon: UIButton!
    @IBOutlet weak var lblItemCount: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnCheckOut: CustomButton!
    @IBOutlet weak var lblNoRecord: UILabel!
    @IBOutlet weak var btnAddMoreService: CustomButton!
    @IBOutlet weak var lblApplyCoupon: UILabel!
    @IBOutlet weak var kLblApplyCouponWdith: NSLayoutConstraint!
    
    var viewModel : OrderViewModel?
    var cartList = [CartListingModel.Datum]()
    var isFromSubCategoriesList : Bool?
    var row = 0
    public static var isCodeApplied = false
    var couponId:String?
    var totalPrice : String?
    
    //MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if OrderListVC.isCodeApplied == true{
            addCoupon_Animation()
        }
        else{
            
        }
        
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
        btnAddMoreService.setTitleColor(Appcolor.kTextColorBlack, for: .normal)
        btnCheckOut.setTitleColor(Appcolor.kTextColorBlack, for: .normal)
        
        self.kOldlPriceWidth.constant = 0
        getCartList()
    }
    
    //MARK:- AddCoupon_Animation
    
    func addCoupon_Animation()
    {
        UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseOut, animations: {
            //  self.lblApplyCoupon.frame = CGRect(x:  80, y: 123, width: 160, height: 12)
            self.kLblApplyCouponWdith.constant = 200
            self.kOldlPriceWidth.constant = 50
            self.kRemoveButtonWidth.constant = 65
            self.imageArrow.isHidden = true
            self.btnApplyCoupon.isUserInteractionEnabled = false
            self.lblApplyCoupon.text =  "Coupon Applied: (New)"
            
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    //MARK:- RemoveCoupon_Animation
    
    func removeCoupon_Animation()
    {
        
        UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseIn, animations: {
            self.lblTotalPrice.text = self.totalPrice
            self.kLblApplyCouponWdith.constant = 0
            self.kOldlPriceWidth.constant = 0
            self.kRemoveButtonWidth.constant = 0
            self.imageArrow.isHidden = false
            self.btnApplyCoupon.isUserInteractionEnabled = true
            OrderListVC.isCodeApplied = false
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseOut, animations: {
            self.kLblApplyCouponWdith.constant = 100
            self.lblApplyCoupon.text =  "Apply Coupon"
            
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    //MARK:- HitApi
    
    func updateCartApi(selectedServiceId:String?,orderPrice:String?,quantity:String?,totalprice:String?,cartId:String?)
    {
        let param = AddtoCartInputModel.init(serviceId: selectedServiceId, addressId: "", serviceDateTime: "", orderPrice:orderPrice, quantity: quantity, orderTotalPrice: totalprice)
        viewModel?.updateToCartValidation(param: param,cartId: cartId)
    }
    func getCartList()
    {
        viewModel?.getCartListApi(completion: { (responce) in
            print(responce)
            if let cartListData = responce.body?.data{
                if cartListData.count > 0
                {
                    self.viewButtons.isHidden = false
                    self.viewTotalPrice.isHidden = false
                    self.couponId = cartListData[0].promoCode
                    self.cartList = cartListData
                    self.totalPrice = "\(responce.body?.totalQunatity ?? 0)"//"$ \(responce.body?.sum ?? 0)"
                    self.lblNoRecord.isHidden = true
                    self.tableViewOrder.isHidden = false
                    self.tableViewOrder.reloadData()
                    
                    //setData
                    // self.lblItemCount.text = "Items ( \(responce.body?.totalQunatity ?? 0) )"
                    self.lblPrice.text = "\(responce.body?.totalQunatity ?? 0)"
                    
                    if (responce.body?.payableAmount != nil && responce.body?.payableAmount != 0){
                        self.lblTotalPrice.text = "$ \(responce.body?.payableAmount ?? 0)"
                        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "$ \(responce.body?.sum ?? 0)")
                        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
                        
                        self.lblOldPrice.attributedText = attributeString
                        
                        self.addCoupon_Animation()
                    }
                    else{
                        self.lblTotalPrice.text = "$ \(responce.body?.sum ?? 0)"
                    }
                }
                else{
                    self.viewButtons.isHidden = true
                    self.viewTotalPrice.isHidden = true
                    self.lblNoRecord.isHidden = false
                    self.tableViewOrder.isHidden = true
                }
            }
            
        })
    }
    
    //RemoveCoupon Api
    func removeCouponApi(id: String?){
        viewModel?.removeCouponApi(Id: id, completion: { (responce) in
            self.AlertMessageWithOkAction(titleStr: kAppName, messageStr: responce.message ?? "", Target: self) {
                self.getCartList()
                // self.removeCoupon_Animation()
            }
        })
    }
    
    //MARK:- Actions
    @IBAction func removePromoCodeAction(_ sender: Any) {
        self.AlertMessageWithOkCancelAction(titleStr: kAppName, messageStr: "Do you want to delete this coupon?", Target: self)
        { (actn) in
            if (actn == KYes)
            {
                self.removeCouponApi(id:self.couponId)
            }
        }
    }
    @IBAction func applyCouponAction(_ sender: Any)
    {
        let controller = Navigation.GetInstance(of: .ApplyPromoCodeVC) as! ApplyPromoCodeVC
        controller.viewDelegate = self
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
        //        let controller = Navigation.GetInstance(of: .PaymentVC) as! PaymentVC
        //        self.push_To_Controller(from_controller: self, to_Controller: controller)
        let vc = UIStoryboard.init(name: kStoryBoard.appointment, bundle: nil).instantiateViewController(withIdentifier: AppointmentDetailIdentifiers.AppointmentDetailVC) as! AppointmentDetailVC
       // vc.selectedServiceId = selectedServiceId
        //vc.serviceDetail = self.serviceDetail
        vc.isFromSubCategoriesList = isFromSubCategoriesList
        self.navigationController?.pushViewController(vc,animated:false)
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
            cell.viewStepper.tag = indexPath.row
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
    func updateCart(index: Int?, stepperValue: String?,totalPrice:String?) {
        updateCartApi(selectedServiceId: self.cartList[index ?? 0].serviceId, orderPrice: self.cartList[index ?? 0].orderPrice, quantity:stepperValue, totalprice: totalPrice, cartId: self.cartList[index ?? 0].id)
    }
    
    func callBack(data:ApplyCouponModel.Body)
    {
        //couponId = data.coupanCode
        getCartList()
        
    }
    
    func updateCart(index: Int?)
    {
        //        let vc = UIStoryboard.init(name: kStoryBoard.appointment, bundle: nil).instantiateViewController(withIdentifier: AppointmentDetailIdentifiers.AppointmentDetailVC) as! AppointmentDetailVC
        //        vc.updateCartId = self.cartList[index ?? 0].id
        //        vc.isEdited = true
        //        // vc.serviceDetail = self.serviceDetail
        //        //vc.isFromSubCategoriesList = isFromSubCategoriesList
        //        self.navigationController?.pushViewController(vc,animated:false)
        
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
