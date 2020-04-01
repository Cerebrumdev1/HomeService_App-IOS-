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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        viewStepper.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
    }
    
//MARK:- Other Functions
    @objc func stepperValueChanged(stepper: GMStepper) {
        print(stepper.value, terminator: "")
    }
    
    func setView()
    {
        imgViewService.layer.cornerRadius = 4
        imgViewService.layer.masksToBounds = true
    }
    @IBAction func deleteOrderAction(_ sender: Any)
    {
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
