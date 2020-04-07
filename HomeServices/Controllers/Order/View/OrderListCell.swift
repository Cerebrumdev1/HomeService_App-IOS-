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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        viewStepper.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
    }
    
//MARK:- Other Functions
    @objc func stepperValueChanged(stepper: GMStepper) {
        print(stepper.value, terminator: "")
    }
    
    func setView(data:CartListingModel.Datum)
    {
        imgViewService.layer.cornerRadius = 4
        imgViewService.layer.masksToBounds = true
        
        lblServiceName.text = data.service?.name
        lblPrice.text = "$ " + (data.orderPrice ?? "0")
        if let url = data.service?.thumbnail
        {
            imgViewService.setImage(with: url, placeholder: "image")
        }
    }
    //MARK:- Actions
    @IBAction func updateCartAction(_ sender: Any)
    {
        viewDelegate?.updateCart(index:(sender as AnyObject).tag)
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
