//
//  MTGSController+UICollectionViewDelegate.swift
//  MTG Sets and Cards
//
//  Created by António Ramos on 07/10/2019.
//  Copyright © 2019 ARdev. All rights reserved.
//

import UIKit

extension MTGSCController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        UIView.animate(withDuration: 0.5) {
            self.setDetailsView.isHidden = false
            self.mainStackView.layoutSubviews()
            self.mainStackView.layoutIfNeeded()
        }
        
        var model: MtgSet
        if filteredCollectionOfSets.isEmpty {
            model = collectionOfSets[indexPath.row]
        } else {
            model = filteredCollectionOfSets[indexPath.row]
        }
        selectedSet = model
        setDetailsView.setupLabelsWith(model)
        
        MTGBigarClient.taskForGetRequest(
            url:     MTGBigarClient.generateUrl(for: "/\(model.id)"),
            handler: handleCardsResponse(response:error:)
        )
    }
}
