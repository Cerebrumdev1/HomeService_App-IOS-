//
//  Enums.swift
//  UnionGoods
//
//  Created by Rakesh Kumar on 11/22/19.
//  Copyright © 2019 Seasia infotech. All rights reserved.
//

import Foundation
import UIKit

class Navigation
{
    enum type
    {
        case root
        case push
        case present
        case pop
    }
    
    enum Controller
    {
        //AUTH
        case CheckOTPVC
        case LoginWithPhoneVC
        case SignUPVC
        case SignInVC
        case ResetPasswordVC
        case ChangePasswdVC
        case NotificationVC
        case SettingVC
        
        //HOME
        case HomeVC
        case EditProfileVC
        case AddressListVC
        case AddNewAddressVC
        case PaymentVC
        case ApplyPromoCodeVC
        
        
        var obj: UIViewController?
        {
            switch self
            {
                
            //AUTH
            case .CheckOTPVC:
                return StoryBoards.Main.obj?.instantiateViewController(withIdentifier: "CheckOTPVC")
                
            case .LoginWithPhoneVC:
                return StoryBoards.Main.obj?.instantiateViewController(withIdentifier: "LoginWithPhoneVC")
                
            case .SignUPVC:
                return StoryBoards.Main.obj?.instantiateViewController(withIdentifier: "SignUPVC")
                
            case .SignInVC:
                return StoryBoards.Main.obj?.instantiateViewController(withIdentifier: "SignInVC")
                
            case .ResetPasswordVC:
                return StoryBoards.Main.obj?.instantiateViewController(withIdentifier: "ResetPasswordVC")
                
            case .ChangePasswdVC:
                return StoryBoards.Main.obj?.instantiateViewController(withIdentifier: "ChangePasswdVC")
                
            case .EditProfileVC:
                return StoryBoards.Main.obj?.instantiateViewController(withIdentifier: "EditProfileVC")
                
            case .NotificationVC:
               return StoryBoards.Main.obj?.instantiateViewController(withIdentifier: "NotificationVC")
           
                case .SettingVC:
                    return StoryBoards.Home.obj?.instantiateViewController(withIdentifier: "SettingVC")
                
                
            //HOME //AddNewAddressVC
            case .HomeVC:
                return StoryBoards.Home.obj?.instantiateViewController(withIdentifier: "HomeVC")
           case .AddressListVC:
                          return StoryBoards.Home.obj?.instantiateViewController(withIdentifier: "AddressListVC")
             case .AddNewAddressVC:
                      return StoryBoards.Home.obj?.instantiateViewController(withIdentifier: "AddNewAddressVC")
            case .PaymentVC:
                return StoryBoards.Payment.obj?.instantiateViewController(withIdentifier: "PaymentVC")
                
            case .ApplyPromoCodeVC:
                return StoryBoards.Order.obj?.instantiateViewController(withIdentifier: "ApplyPromoCodeVC")
      
            }
        }
    }
    enum StoryBoards
    {
        case Main
        case Home
        case Payment
        case Order
        
        var obj: UIStoryboard?
        {
            switch self
            {
            case .Main:
                return UIStoryboard(name: "Main", bundle: nil)
            case .Home:
                return UIStoryboard(name: "Home", bundle: nil)
            case .Payment:
                return UIStoryboard(name: "Payment", bundle: nil)
            case .Order:
                return UIStoryboard(name: "Order", bundle: nil)
            }
        }
        
    }
    
    static func GetInstance(of controller : Controller) -> UIViewController
    {
        return controller.obj!
    }
    
}

