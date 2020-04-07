//
//  TimeSlotCollectionCell.swift
//  HomeServices
//
//  Created by Navaldeep Kaur on 01/04/20.
//  Copyright © 2020 Atinder Kaur. All rights reserved.
//

import UIKit

class TimeSlotCollectionCell: UICollectionViewCell
{
    //MARK:- OUTLET 
    @IBOutlet weak var viewBack: CustomUIView!
    @IBOutlet weak var lblTimeSlot: UILabel!
    
    var index:Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print("First")
        if index == 0
        {
            lblTimeSlot.textColor = AppButtonColor.kBlueColor
            viewBack.backgroundColor = AppButtonColor.kLightBlueColor
            viewBack.layer.borderWidth = 1
            viewBack.layer.borderColor = AppButtonColor.kBlueColor.cgColor
        }
        else{
            lblTimeSlot.textColor = UIColor.darkGray
            viewBack.backgroundColor = .white
            viewBack.layer.borderWidth = 1
            viewBack.layer.borderColor = UIColor.darkGray.cgColor
        }
    }
    
    //MARK:- Other Functions
    //    override var isSelected: Bool {
    //        didSet {
    //            if isSelected {
    //                lblTimeSlot.textColor = AppButtonColor.kBlueColor
    //                viewBack.backgroundColor = AppButtonColor.kLightBlueColor
    //                viewBack.layer.borderWidth = 1
    //                viewBack.layer.borderColor = AppButtonColor.kBlueColor.cgColor
    //            } else {
    //                lblTimeSlot.textColor = UIColor.darkGray
    //                viewBack.backgroundColor = .white
    //                viewBack.layer.borderWidth = 1
    //                viewBack.layer.borderColor = UIColor.darkGray.cgColor
    //            }
    //        }
    //    }
}
