//
//  TrendingServiceCollectionCell.swift
//  Fleet Management
//
//  Created by Navaldeep Kaur on 21/03/20.
//  Copyright © 2020 Seasia Infotech. All rights reserved.
//

import UIKit

class TrendingServiceCollectionCell: UICollectionViewCell {
    
    //MARK:- OUtLet And Variables
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblServiceName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    //MARK:- other Functions
    func setView(data:TrendingService){
        self.viewBack.layer.cornerRadius = 10
        self.viewBack.layer.masksToBounds = true
        self.viewBack.layer.borderWidth = 0.5
        self.viewBack.layer.borderColor = UIColor.init(netHex: 0xD9D4D4).cgColor
        
        //setData
        if let url = data.icon
        {
              self.imageView.setImage(with: url, placeholder: KImages.KDefaultIcon)
              }
        lblServiceName.text = data.name
    }
}
