//
//  UIViewControllerExtension.swift
//  MTG Sets and Cards
//
//  Created by António Ramos on 06/10/2019.
//  Copyright © 2019 ARdev. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentAlert(message: String) {
        
        let alert = UIAlertController(title: "Counterspell", message: message, preferredStyle: .alert)
        let alertButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(alertButton)
        present(alert, animated: true)
    }
    
}
