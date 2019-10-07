//
//  UIViewExtension.swift
//  MTG Sets and Cards
//
//  Created by António Ramos on 07/10/2019.
//  Copyright © 2019 ARdev. All rights reserved.
//

import UIKit

extension UIView {
    
    func applyLayerStyle(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: CGColor) {
        
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
        
    }
}
