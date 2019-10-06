//
//  SetDetailsView.swift
//  MTG Sets and Cards
//
//  Created by António Ramos on 06/10/2019.
//  Copyright © 2019 ARdev. All rights reserved.
//

import UIKit

class SetDetailsView: UIView {
    
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var cardsCountLabel: UILabel!
    @IBOutlet weak var blockLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewWith()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if self.subviews.count == 0 {
            setupViewWith()
        } else {
            for view in self.subviews {
                if view.isKind(of: UIView.self) {
                    view.removeFromSuperview()
                }
            }
        }
    }
    
    func setupViewWith(_ set: MtgSet? = nil) {
        
        Bundle.main.loadNibNamed("SetDetailsView", owner: self, options: nil)
        guard let content = contentView else {return}
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(contentView)
        
        guard let mtgSet = set else {return}
        var cardsCountText: String {
            return mtgSet.cardCount == 1 ? "\(mtgSet.cardCount) card" : "\(mtgSet.cardCount) cards"
        }
        
        //releaseDateLabel.text = mtgSet.releaseDate.toFormattedDate(withFormat: "MMM dd,yyyy")
        cardsCountLabel.text = cardsCountText
        blockLabel.text = mtgSet.block == nil ? "" : "Block: \(mtgSet.block ?? "")"
    }
}
