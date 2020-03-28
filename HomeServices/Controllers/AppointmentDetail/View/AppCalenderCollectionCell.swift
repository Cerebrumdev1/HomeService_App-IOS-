//
//  AppCalenderCollectionCell.swift
//  HomeServices
//
//  Created by Navaldeep Kaur on 27/03/20.
//  Copyright © 2020 Atinder Kaur. All rights reserved.
//

import UIKit

class AppCalenderCollectionCell: UICollectionViewCell {
    
    //MARK:- Outlet and Variables
    @IBOutlet weak var viewBack: CustomUIView!
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    static var isCurrentDate:Bool?
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK:- Other Functions
    override var isSelected: Bool {
        didSet {
            if isSelected {
                if AppCalenderCollectionCell.isCurrentDate == true
                {
                    lblDate!.textColor = UIColor.darkText
                    lblDay.textColor =  UIColor.darkText
                    viewBack.layer.borderColor = UIColor.darkGray.cgColor
                }
                lblDate!.textColor = AppButtonColor.kBlueColor
                viewBack.layer.borderColor = AppButtonColor.kBlueColor.cgColor
                lblDay.textColor = AppButtonColor.kBlueColor
                // lblDate.font = UIFont.boldSystemFont(ofSize: 14)
            } else {
                lblDate!.textColor = UIColor.darkText
                lblDay.textColor =  UIColor.darkText
                viewBack.layer.borderColor = UIColor.darkGray.cgColor
                // lblDate.font = UIFont.systemFont(ofSize: 14)
            }
        }
    }
    
}
