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
    
    //MARK: Outlets
    
    @IBOutlet weak var cardImageView: UIImageView!
    
    //MARK: Properties
    
    var stringUrl: URL?
    
    //MARK: View life cycle
    
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
    
    //MARK: Actions
    
    @IBAction func dismissControllerOnScreenTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
