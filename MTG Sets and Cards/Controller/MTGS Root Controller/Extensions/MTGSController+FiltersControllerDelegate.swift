//
//  MTGSController+FiltersControllerDelegate.swift
//  MTG Sets and Cards
//
//  Created by António Ramos on 07/10/2019.
//  Copyright © 2019 ARdev. All rights reserved.
//

import Foundation

extension MTGSCController: FiltersControllerDelegate {
    
    func filtersController(didApplyFiltersIn array: [MtgSet]) {
        filteredCollectionOfSets = array
        
        collectionView.reloadData()
    }
}

