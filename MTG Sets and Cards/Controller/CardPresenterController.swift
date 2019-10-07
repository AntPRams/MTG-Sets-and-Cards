//
//  AlertController.swift
//  MTG Sets and Cards
//
//  Created by António Ramos on 06/10/2019.
//  Copyright © 2019 ARdev. All rights reserved.
//

import UIKit
import SDWebImage

class CardPresenterController: UIViewController {
    
    @IBOutlet weak var cardImageView: UIImageView!
    var stringUrl: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cardImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        cardImageView.sd_setImage(with: stringUrl) { (image, error, cache, url) in
            if error != nil {
                self.presentAlert(message: error?.localizedDescription)
            } else {
                self.cardImageView.image = image
            }
        }
    }
    
    @IBAction func dismissControllerOnScreenTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
   

}
