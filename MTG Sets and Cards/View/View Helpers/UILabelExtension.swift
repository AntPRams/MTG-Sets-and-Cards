//
//  UILabelExtension.swift
//  MTG Sets and Cards
//
//  Created by António Ramos on 06/10/2019.
//  Copyright © 2019 ARdev. All rights reserved.
//

import UIKit

//Used to animate labels when text change and to add text attributes

extension UILabel {
    
    func changeTextWithAnimation(_ text: String, stackView: UIStackView? = nil) {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { (finished) in
            self.text = text
            UIView.animate(withDuration: 0.3, animations: {
                self.isHidden = self.text == "" ? true : false
                self.alpha = 1
            })
            guard let stackView = stackView else {return}
            stackView.layoutSubviews()
            stackView.layoutIfNeeded()
        }
    }
    
    func addLabelAttributes(font: UIFont, text: String, color: UIColor){
        
        let attributes: [NSAttributedString.Key : Any] = [
            .strokeColor : UIColor.darkGray,
            .strokeWidth : -2,
            .font : font,
            .foregroundColor : color
        ]
        
       self.attributedText = NSAttributedString(string: text, attributes: attributes)
    }
}
