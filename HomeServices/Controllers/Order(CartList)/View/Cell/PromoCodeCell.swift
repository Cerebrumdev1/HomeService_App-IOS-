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
    @IBOutlet weak var lblCode: UILabel!
    @IBOutlet weak var viewCodeBack: UIView!
    @IBOutlet weak var lblRecommended: UILabel!
    
    var viewDelegate : ApplyPromoCodeDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //MARK:- Actions
    @IBAction func applyCodeAction(_ sender: Any) {
        viewDelegate?.applyCode(index: (sender as AnyObject).tag)
    }
    
    //MARK:- Other Functions
    
    func setData(data:PromoCodeModel.Body?)
    {
        //viewCodeBack.addDashedBorder()
        lblApplyDetail.text = "\(data?.discount ?? "0") % Discount"
        lblDetail.text = data?.description ?? ""
        lblRecommended.text = data?.name ?? ""
        lblCode.text = data?.code ?? ""
    }
    
}
