//
//  SetDetailsView.swift
//  MTG Sets and Cards
//
//  Created by António Ramos on 06/10/2019.
//  Copyright © 2019 ARdev. All rights reserved.
//

import UIKit

class SetDetailsView: UIView {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var cardsCountLabel: UILabel!
    @IBOutlet weak var blockLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
            setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
            setupView()
    }
    
    func setupView() {
        
        Bundle.main.loadNibNamed("SetDetailsView", owner: self, options: nil)
        
        guard let container = containerView else {return}
        container.backgroundColor = .clear
        container.frame = self.bounds
        container.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(container)
    }
    
    func setupLabelsWith(_ model: MtgSet) {
        
        [releaseDateLabel, cardsCountLabel, blockLabel].forEach{
            $0?.font = UIFont.belerenMedium
            $0?.textColor = UIColor.white
        }
        
        var cardsCountText: String {
            return model.cardCount == 1 ? "\(model.cardCount) card" : "\(model.cardCount) cards"
        }
        
        releaseDateLabel.changeTextWithAnimation("Release: \(model.releaseDate.dateFormatModifier(dateFormat: "MMM dd,yyyy"))")
        cardsCountLabel.changeTextWithAnimation(cardsCountText)
        blockLabel.changeTextWithAnimation(model.block ?? "", stackView: stackView)
        
    }
}
