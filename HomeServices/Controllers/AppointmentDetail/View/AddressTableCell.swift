//
//  AddressTableCell.swift
//  HomeServices
//
//  Created by Navaldeep Kaur on 31/03/20.
//  Copyright © 2020 Atinder Kaur. All rights reserved.
//

import UIKit

class AddressTableCell: UITableViewCell {
    
    //MARK:- Outlet and Variables
    @IBOutlet weak var lblAddress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
