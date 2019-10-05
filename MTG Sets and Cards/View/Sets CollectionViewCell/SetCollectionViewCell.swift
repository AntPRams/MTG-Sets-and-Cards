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

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var setIconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCellWith(_ set: MtgSet) {
        
        let attributes: [NSAttributedString.Key : Any] = [
            .strokeColor : UIColor.white,
            .strokeWidth : -4,
            .font : UIFont.belerenLarge!
        ]
        
        titleLabel.attributedText = NSAttributedString(string: set.name, attributes: attributes)
        //titleLabel.text = set.name
        guard let defaultImage = UIImage(named: "pmei") else {return}
        let setIcon = UIImage(named: set.code) ?? defaultImage
        setIconImageView.image = setIcon
    }

}
