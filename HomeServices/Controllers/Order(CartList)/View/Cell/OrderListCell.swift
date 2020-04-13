//
//  OrderListCell.swift
//  HomeServices
//
//  Created by Navaldeep Kaur on 31/03/20.
//  Copyright © 2020 Atinder Kaur. All rights reserved.
//

import UIKit
import  Cosmos

class OrderListCell: UITableViewCell {
    
    //MARK:- Outlet and Variables
    @IBOutlet weak var imgViewService: UIImageView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var viewRating: CosmosView!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var lblServiceName: UILabel!
    @IBOutlet weak var viewStepper: GMStepper!
    @IBOutlet weak var btnUpdate: CustomButton!
    
    var viewDelegate : CartListDelegate?
    var totalPrice : String?
    var orderPrice : String?
    var servicePrice:String?
    var isStepperClicked = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        viewStepper.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
    }
    
    //MARK:- Other Functions
    @objc func stepperValueChanged(stepper: GMStepper) {
        print(stepper.value, terminator: "")
        totalPrice = servicePrice
        if (stepper.value == 0)
        {
            lblPrice.text = "$ " + (servicePrice ?? "0")
        }
        else
        {
            if let rate = orderPrice
            {
                let totalRate = (Double(rate)!  * stepper.value)
                lblPrice.text =   "$ \(Int(totalRate))"
                totalPrice = "\(Int(totalRate))"
            }
        }
        viewDelegate?.updateCart(index:(stepper as AnyObject).tag, stepperValue: "\(Int(stepper.value))", totalPrice: totalPrice)
    }
    
    func setView(data:CartListingModel.Datum)
    {
        imgViewService.layer.cornerRadius = 4
        imgViewService.layer.masksToBounds = true
        self.viewStepper.minimumValue = 1
        self.viewStepper.value = Double(data.quantity ?? "") ?? 0.0
        lblServiceName.text = data.service?.name
        orderPrice = data.orderPrice ?? "0"
        servicePrice = data.orderTotalPrice ?? "0"
        lblPrice.text = "$ " + (data.orderTotalPrice ?? "0")
        if let url = data.service?.thumbnail
        {
            imgViewService.setImage(with: url, placeholder: "image")
        }
    }
    //MARK:- Actions
    @IBAction func updateCartAction(_ sender: Any)
    {
        //viewDelegate?.updateCart(index:(sender as AnyObject).tag)
    }
    @IBAction func deleteOrderAction(_ sender: Any)
    {
        viewDelegate?.removeFromCart(index:(sender as AnyObject).tag)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
