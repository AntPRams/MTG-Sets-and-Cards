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
    
    //MARK: Outlets
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.backgroundColor = UIColor.white.withAlphaComponent(0.8)
            containerView.applyLayerStyle(
                cornerRadius: 12,
                borderWidth:  5,
                borderColor:  UIColor.black.cgColor)
        }
    }
    
    @IBOutlet weak var cardImageView: UIImageView! {
        didSet {
        cardImageView.layer.cornerRadius = 12
        }
    }
    
    @IBOutlet weak var rarityImageView: UIImageView!
    @IBOutlet weak var cardNameLabel:   UILabel!
    @IBOutlet weak var stackView:       UIStackView!
    @IBOutlet weak var cardTypeLabel:   UILabel!
    
    //MARK: Properties
    
    var handleError: ((Error?)->Void)?
    static let identifier = "CardTableViewCell"
    
    //MARK: Awake!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
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

    //MARK: Methods
    
    func setupCellWith(_ model: MtgCard) {
        
        if model.setReleaseDate.returnYearFromDate() < 2003 {
            cardNameLabel.addLabelAttributes(font: UIFont.planeswalkerMedium, text: model.name, color: .black)
        } else {
            cardNameLabel.addLabelAttributes(font: UIFont.belerenMedium, text: model.name, color: .black)
        }
        cardTypeLabel.text = model.type
        rarityImageView.image = UIImage(named: model.rarity)!
        cardImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        cardImageView.sd_setImage(with: model.artCropImageUrl) { (image, error, cache, url) in
            if error != nil {
                self.handleError?(error)
            } else {
                self.cardImageView.image = image
            }
        }
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
