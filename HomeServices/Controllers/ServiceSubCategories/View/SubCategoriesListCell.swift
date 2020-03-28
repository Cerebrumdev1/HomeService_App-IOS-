//
//  SubCategoriesListCell.swift
//  Fleet Management
//
//  Created by Navaldeep Kaur on 25/03/20.
//  Copyright © 2020 Seasia Infotech. All rights reserved.
//

import UIKit

class SubCategoriesListCell: UITableViewCell {

    //MARK:- outlet and variables
    
    @IBOutlet weak var imageViewService: UIImageView!
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var btnRepair: CustomButton!
    @IBOutlet weak var lblServiceName: UILabel!
    @IBOutlet weak var lblPerPrice: UILabel!
    @IBOutlet weak var lblServiceTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //MARK:- other functions
    
    func setData(categoriesList:BodyList)
    {
        //setColor
        btnRepair.backgroundColor = AppButtonColor.kBlueColor
        btnRepair.setTitleColor(UIColor.white, for: .normal)
        lblRate.textColor = AppButtonColor.kBlueColor
        
        //setData
        lblServiceName.text = categoriesList.name
        lblRate.text = "$ " + (categoriesList.serviceType?.price ?? "")
        if let url = categoriesList.thumbnail
        {
          self.imageViewService.setImage(with: url, placeholder: "image")
        }
        btnRepair.setTitle(categoriesList.serviceType?.name ?? "Repair", for: .normal)
        lblPerPrice.text = "/" + (categoriesList.serviceType?.type ?? "")
    
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
