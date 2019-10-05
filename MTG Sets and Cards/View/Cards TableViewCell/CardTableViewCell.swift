//
//  CardTableViewCell.swift
//  MTG Sets and Cards
//
//  Created by António Ramos on 04/10/2019.
//  Copyright © 2019 ARdev. All rights reserved.
//

import UIKit
import SDWebImage

class CardTableViewCell: UITableViewCell {
    
    static let identifier = "CardTableViewCell"

    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCellWith(_ model: MtgCard) {
        cardName.text = model.name
        cardImage.sd_setImage(with: model.smallImageUrl, placeholderImage: UIImage(named: "placeholder"), options: .highPriority, completed: nil)
        cardImage.layer.applyMask()
    }
}
