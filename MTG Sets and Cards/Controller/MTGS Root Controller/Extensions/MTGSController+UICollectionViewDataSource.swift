//
//  MTGSController+UICollectionViewDataSource.swift
//  MTG Sets and Cards
//
//  Created by António Ramos on 07/10/2019.
//  Copyright © 2019 ARdev. All rights reserved.
//

import UIKit

extension MTGSCController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if filteredCollectionOfSets.isEmpty {
            return collectionOfSets.count
        } else {
            return filteredCollectionOfSets.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: SetCollectionViewCell.identifier, for: indexPath) as! SetCollectionViewCell
        
        var model: MtgSet
        
        if filteredCollectionOfSets.isEmpty {
            model = collectionOfSets[indexPath.row]
        } else {
            model = filteredCollectionOfSets[indexPath.row]
        }
        
        cell.setupCellWith(model)
        cell.backgroundColor = .clear
        
        return cell
    }
}
