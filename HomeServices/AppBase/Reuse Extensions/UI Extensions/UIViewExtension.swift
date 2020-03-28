//
//  UIViewExtension.swift
//  Fleet Management
//
//  Created by Mohit Sharma on 2/25/20.
//  Copyright © 2020 Seasia Infotech. All rights reserved.
//

import Foundation
import UIKit

class RoundShadowView: UIView
{
    
    private var shadowLayer: CAShapeLayer!
    private var cornerRadius: CGFloat = 10.0
    private var fillColor: UIColor = .white // the color applied to the shadowLayer, rather than the view's backgroundColor
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.fillColor = fillColor.cgColor
            
            shadowLayer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 1.0)
            shadowLayer.shadowOpacity = 0.8
            shadowLayer.shadowRadius = 3
            
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
    
}


class RoundView: UIView
{
    
    private var cornerRadius: CGFloat = 10.0
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        
    }

}

