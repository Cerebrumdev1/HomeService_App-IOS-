//
//  CellClass_OrderList.swift
//  UrbanClap Replica
//
//  Created by Mohit Sharma on 4/8/20.
//  Copyright © 2020 Seasia Infotech. All rights reserved.
//

import UIKit

class CellClass_OrderList: UITableViewCell
{

    @IBOutlet var lblHeadingService: UILabel!
    @IBOutlet var lblBookedOn: UILabel!
    @IBOutlet var lblTotal: UILabel!
    @IBOutlet var btnCencel: UIButton!
    
    @IBOutlet var cellCollectionView: UICollectionView!
    @IBOutlet var cellCollectionHeight: NSLayoutConstraint!
    
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
    func hideAnimation()
    {
        [self.lblHeadingService,self.lblBookedOn,self.lblTotal,self.btnCencel].forEach
        {
            $0?.hideSkeleton()
        }
    }
    
    func showAnimation()
    {
        [self.lblHeadingService,self.lblBookedOn,self.lblTotal,self.btnCencel].forEach
        {
            $0?.showAnimatedGradientSkeleton()
        }
    }

}





class CellClass_CellCollection: UICollectionViewCell
{

    @IBOutlet var iv: UIImageView!
    @IBOutlet var lblSrviceName: UILabel!
    @IBOutlet var lblQuantity: UILabel!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblTime: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    

}

