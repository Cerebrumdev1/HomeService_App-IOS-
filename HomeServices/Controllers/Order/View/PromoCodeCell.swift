//
//  PromoCodeCell.swift
//  HomeServices
//
//  Created by Navaldeep Kaur on 06/04/20.
//  Copyright © 2020 Atinder Kaur. All rights reserved.
//

import UIKit

class PromoCodeCell: UITableViewCell {

    //MARK:- Outlet and Variables
    
 
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var lblApplyDetail: UILabel!
    @IBOutlet weak var viewImageBack: UIView!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var btnApply: CustomButton!
    @IBOutlet weak var lblRecommended: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func applyCodeAction(_ sender: Any) {
    }
    
}
