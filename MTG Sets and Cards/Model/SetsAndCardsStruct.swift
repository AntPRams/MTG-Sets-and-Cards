//
//  SetsAndCardsStruct.swift
//  MTG Sets and Cards
//
//  Created by António Ramos on 04/10/2019.
//  Copyright © 2019 ARdev. All rights reserved.
//

import UIKit

struct MtgSet {
    
    let name: String
    let id: String
    let code: String
    let releaseDate: String
    let cardCount: Int
    let block: String?
}

struct MtgCard {
    
    let name: String
    let smallImageUrl: URL?
    let artCropImageUrl: URL?
    let manaCost: String
    let rarity: String
}
