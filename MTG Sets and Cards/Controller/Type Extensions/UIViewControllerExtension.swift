//
//  UIViewControllerExtension.swift
//  MTG Sets and Cards
//
//  Created by António Ramos on 06/10/2019.
//  Copyright © 2019 ARdev. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentAlert(message: String?) {
        
        guard let alertMessage = message else {return}
        
        let alert = UIAlertController(title: "Counterspell", message: alertMessage, preferredStyle: .alert)
        let alertButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(alertButton)
        present(alert, animated: true)
    }
    
    func setBackgroundImage() {
         
         let backgroundImageView = UIImageView()

         backgroundImageView.image = UIImage(named: "background")
         backgroundImageView.contentMode = .scaleAspectFill
         backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
    
         view.insertSubview(backgroundImageView, at: 0)
         
         backgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
         backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
         backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
         backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
     }
    
}
