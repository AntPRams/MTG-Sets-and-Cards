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
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.backgroundColor = UIColor.white.withAlphaComponent(0.8)
            containerView.layer.cornerRadius = 12
            containerView.layer.borderWidth = 5
            containerView.layer.borderColor = UIColor.black.cgColor
        }
    }
    @IBOutlet weak var cardImageView: UIImageView! {
        didSet {
        cardImageView.layer.cornerRadius = 12
        
        }
    }
    @IBOutlet weak var rarityImageView: UIImageView!
    
    @IBOutlet weak var cardNameLabel: UILabel! {
        didSet {
            cardNameLabel.font = UIFont.belerenMedium
        }
    }
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var cardTypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
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
        
        cardNameLabel.text = model.name
        cardTypeLabel.text = model.type
        rarityImageView.image = UIImage(named: model.rarity)!
        cardImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        cardImageView.sd_setImage(with: model.artCropImageUrl, completed: nil)
        cardImageView.layer.applyMask()
        applyManaCostImages(model.manaCost)
    }
    
    private func applyManaCostImages(_ string: String) {
        
        var newString: String = ""
        string.forEach {
            newString.append($0)
            if $0 == "}" {
                newString.append(" ")
            }
        }
        
        let components = newString.components(separatedBy: .whitespaces)
        let cost = components.filter({!$0.isEmpty})
        
        cost.forEach({ (manaCostSymbol) in
            print(cost.count)
            let imageView = UIImageView()
            imageView.backgroundColor = .clear
            imageView.contentMode = ContentMode.scaleAspectFit
            stackView.addArrangedSubview(imageView)
            
            if manaCostSymbol == "//" {
                imageView.image = UIImage(named: "dual")
            } else if manaCostSymbol != " "{
                var imageName: String {
                    if manaCostSymbol.contains("/") {
                        return manaCostSymbol.replacingOccurrences(of: "/", with: ":")
                    } else {
                        return manaCostSymbol
                    }
                }
                imageView.image = UIImage(named: imageName)
            } else {
                return
            }
            
            stackView.layoutIfNeeded()
            stackView.layoutSubviews()
        })
    }
}
