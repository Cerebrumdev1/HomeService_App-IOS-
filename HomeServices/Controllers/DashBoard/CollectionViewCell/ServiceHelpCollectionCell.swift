//
//  ServiceHelpCollectionCell.swift
//  Fleet Management
//
//  Created by Navaldeep Kaur on 21/03/20.
//  Copyright © 2020 Seasia Infotech. All rights reserved.
//

import UIKit

class ServiceHelpCollectionCell: UICollectionViewCell {
    
    //MARK:- Outlet and Variables
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblServiceName: UILabel!
    
    //MARK:- other Functions
    func setView(data: Service)
    {
        self.viewBack.layer.borderWidth = 0.5
        self.viewBack.layer.borderColor = UIColor.init(netHex: 0xD9D4D4).cgColor
        self.viewBack.dropShadow(radius:20.0)
        // self.viewBack.backgroundColor = UIColor.init(netHex: 0xFFA400)
        
        //setData
        if let url = data.icon{
            self.imageView.setImage(with: url, placeholder: "image")
        }
        lblServiceName.text = data.name
    }
    @IBAction func BtnACtion(_ sender: Any) {
        print("Selected")
    }
}
