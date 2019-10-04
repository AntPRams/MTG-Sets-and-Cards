//
//  CollectionViewCell.swift
//  MTG Sets and Cards
//
//  Created by António Ramos on 04/10/2019.
//  Copyright © 2019 ARdev. All rights reserved.
//

import UIKit

class SetCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SetCollectionViewCell"

    @IBOutlet weak var setTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
