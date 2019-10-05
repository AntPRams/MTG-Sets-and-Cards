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
    @IBOutlet weak var cardName: UILabel! {
        didSet {
            cardName.font = UIFont.belerenMedium
        }
    }
    @IBOutlet weak var stackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardImage.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        for view in stackView.subviews {
            if view.isKind(of: UIImageView.self) {
                view.removeFromSuperview()
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCellWith(_ model: MtgCard) {
        cardName.text = model.name
        cardImage.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        cardImage.sd_setImage(with: model.artCropImageUrl, completed: nil)
        cardImage.layer.applyMask()
        dealWithManaCost(model.manaCost)
    }
    
    private func dealWithManaCost(_ string: String) {
        
        var newString: String = ""
        string.forEach {
            newString.append($0)
            if $0 == "}" {
                newString.append(" ")
            }
        }
        
        let components = newString.components(separatedBy: .whitespaces)
        let cost = components.filter({!$0.isEmpty})
        print(components)
        
        cost.forEach({
            print(cost.count)
            let imageView = UIImageView()
            imageView.backgroundColor = .clear
            imageView.contentMode = ContentMode.scaleAspectFit
            stackView.addArrangedSubview(imageView)
            imageView.image = UIImage(named: $0)
            print("\($0)imageviewadded")
            stackView.layoutIfNeeded()
            stackView.layoutSubviews()
        })
        print(stackView.subviews.count)
    }
}
