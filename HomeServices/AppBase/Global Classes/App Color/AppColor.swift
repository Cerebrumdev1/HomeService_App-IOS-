//
//  AppColor.swift
//  GoodsDelivery
//
//  Created by Gurleen Osahan on 11/29/19.
//  Copyright © 2019 Seasia infotech. All rights reserved.
//

import Foundation
import UIKit


struct Appcolor
{
    
    static let kThemeYellowColor = UIColor.init(red: 255.0/255.0, green: 175.0/255.0, blue: 16.0/255.0, alpha: 1.0)//yellow for now
     static let kThemeBlueColor = UIColor.init(red: 0.0/255.0, green: 119.0/255.0, blue: 213.0/255.0, alpha: 1.0)//blue for now
    
    static let kButtonBackgroundColor = UIColor.init(red: 52.0/255.0, green: 199.0/255.0, blue: 89.0/255.0, alpha: 1.0)//green for now
    static let kButtonBackgroundColorWhite = UIColor.init(red: 255.0/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
    
    static let kTextFieldBackgroundColor = UIColor.init(red: 225/255.0, green: 225/255.0, blue: 225/255.0, alpha: 1.0)//Gray
    
    static let kLabelBackgroundColor = UIColor.init(red: 225/255.0, green: 225/255.0, blue: 225/255.0, alpha: 1.0)//white
    
    static let kImageBackgroundColor = UIColor.init(red: 225/255.0, green: 225/255.0, blue: 225/255.0, alpha: 1.0)//white
    
    static let kTextColorWhite = UIColor.init(red: 255.0/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
    static let kTextColorBlack = UIColor.init(red: 0.0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
    static let kTextColorGrayDark = UIColor.init(red: 67.0/255.0, green: 67/255.0, blue: 67/255.0, alpha: 1.0)
    static let kTextColorGray = UIColor.init(red: 154.0/255.0, green: 154/255.0, blue: 154/255.0, alpha: 1.0)
    
    static let kViewBackgroundColorWhite = UIColor.init(red: 255.0/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)//white
    static let kViewBackgroundColor = UIColor.init(red: 255.0/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)//white
    
    static let kNavBarColor = UIColor.init(red: 52.0/255.0, green: 199.0/255.0, blue: 89.0/255.0, alpha: 1.0)//green for now
    
    static let kDefaultTintColorBlue = UIColor.init(red: 2.0/255.0, green: 190.0/255.0, blue: 170.0/255.0, alpha: 1.0)//blue default
    
    static let kTheme_Color = UIColor.init(red: 52.0/255.0, green: 199.0/255.0, blue: 89.0/255.0, alpha: 1.0)//green for now
    
    static let kGray = UIColor.init(red: 67/255.0, green: 67/255.0, blue: 67/255.0, alpha: 1.0)
    
    
}

class colorHandler
{
    class func set_button_image_with_color_change(imgName:String,button:UIButton,colorApproach:UIColor)
    {
        let origImage = UIImage(named: imgName)
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: .normal)
        button.tintColor = colorApproach
    }
    
    class func set_button_BG_image_with_color_change(imgName:String,button:UIButton,colorApproach:UIColor)
    {
        let origImage = UIImage(named: imgName)
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        button.setBackgroundImage(tintedImage, for: .normal)
        button.tintColor = colorApproach
    }
    
    class func set_image_with_color_change(imgName:String,imgView:UIImageView,colorApproach:UIColor) -> UIImageView
    {
        if let myImage = UIImage(named: imgName)
        {
            let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
            imgView.image = tintableImage
            imgView.tintColor = colorApproach
            return imgView
        }
        return UIImageView()
    }
}

//MARK:- Colors

struct AppButtonColor
{
    
    static let kBlueColor = UIColor.init(red: 51.0/255.0, green: 116.0/255.0, blue: 218.0/255.0, alpha: 1.0)//blue for now
     static let kOrangeColor = UIColor.init(red: 255.0/255.0, green: 175.0/255.0, blue: 16.0/255.0, alpha: 1.0)//Orange for now
}

struct TextColor{
    static let kGreenColor = UIColor.init(red: 14.0/255.0, green: 164.0/255.0, blue: 47.0/255.0, alpha: 1.0)//Green for now
    static let kRedColor = UIColor.init(red: 207.0/255.0, green: 24.0/255.0, blue: 24.0/255.0, alpha: 1.0)//Red for now
}
