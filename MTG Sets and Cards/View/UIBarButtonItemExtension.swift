//
//  UIBarButtonItemExtension.swift
//  MTG Sets and Cards
//
//  Created by António Ramos on 07/10/2019.
//  Copyright © 2019 ARdev. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    func setAppearance(with font: UIFont, color: UIColor, for state: UIControl.State) {

        self.setTitleTextAttributes([
            .font : font,
            .foregroundColor : color
        ], for: state)
    }
}
