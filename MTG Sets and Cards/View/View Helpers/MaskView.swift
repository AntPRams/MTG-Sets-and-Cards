//
//  MaskView.swift
//  MTG Sets and Cards
//
//  Created by António Ramos on 05/10/2019.
//  Copyright © 2019 ARdev. All rights reserved.
//

import UIKit

//Used to apply a mask in CardTableViewCell

extension CALayer {
    
    func applyMask() {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.backgroundColor = UIColor.clear.cgColor
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.2, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        self.mask = gradientLayer
    }
}
