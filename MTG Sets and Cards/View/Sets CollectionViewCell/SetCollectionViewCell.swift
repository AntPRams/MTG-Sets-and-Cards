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
        
        if set.releaseDate.returnYearFromDate() < 2003 {
            titleLabel.addLabelAttributes(font: UIFont.planeswalkerLarge, text: set.name)
        } else {
            titleLabel.addLabelAttributes(font: UIFont.belerenLarge, text: set.name)
        }
        
        
        
        guard let defaultImage = UIImage(named: "pmei") else {return}
        let setIcon = UIImage(named: set.code.identifyPromoSets(setName: set.name)) ?? defaultImage
        setIconImageView.image = setIcon
    }

}
