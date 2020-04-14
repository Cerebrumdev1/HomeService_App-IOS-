//
//  SuccessVC.swift
//  HomeServices
//
//  Created by Navaldeep Kaur on 08/04/20.
//  Copyright © 2020 Atinder Kaur. All rights reserved.
//

import UIKit
import Lottie

class SuccessVC: UIViewController {
    
    //MARK:- Outlet and Variables
    @IBOutlet weak var viewLottie: UIView!
    @IBOutlet weak var btnBack: CustomButton!
    
    let animationView = AnimationView(name: "lf30_editor_Y2cVsZ")
    
    //MARK:- life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        
    }
    override func viewDidAppear(_ animated: Bool)
    {
        
        animationView.loopMode = .playOnce
        viewLottie.addSubview(animationView)
       let keypath = AnimationKeypath(keys: ["**", "Fill", "**", "Color"])
        let colorProvider = ColorValueProvider(AppButtonColor.kBlueColor.lottieColorValue)
        animationView.setValueProvider(colorProvider, keypath: keypath)

        animationView.play()
    }
    
    //MARK:- other functions
    func setView()
    {
        self.hideNAV_BAR(controller: self)
        
        animationView.frame = viewLottie.frame
        animationView.contentMode = .scaleAspectFit
        //setColor
        btnBack.backgroundColor = AppButtonColor.kBlueColor
        btnBack.setTitleColor(Appcolor.kTextColorWhite, for: .normal)
    }
    //MARK:- Actions
    @IBAction func backAction(_ sender: Any)
    {
        if (self.navigationController != nil) {
            for vc in  self.navigationController!.viewControllers
            {
                if vc is HomeVC {
                    self.navigationController?.popToViewController(vc, animated: false)
                }
            }
        }
    }
}
