//
//  UILabelExtension.swift
//  MTG Sets and Cards
//
//  Created by António Ramos on 06/10/2019.
//  Copyright © 2019 ARdev. All rights reserved.
//

import UIKit

extension UILabel {
    
    func changeTextWithAnimation(_ text: String, fadeOutIn: Bool = true) {
        
        UIView.animate(withDuration: 0.3, animations: {
            if fadeOutIn {
            self.alpha = 0
            } else {
                self.alpha = 1
            }
        }) { (finished) in
            self.text = text
            UIView.animate(withDuration: 0.3, animations: {
                self.alpha = 1
            })
        }
    }
}
