//
//  DictionaryExtension.swift
//  MTG Sets and Cards
//
//  Created by António Ramos on 07/10/2019.
//  Copyright © 2019 ARdev. All rights reserved.
//

import Foundation

//Used to retrieve the key from a value

extension Dictionary where Key == String, Value: Equatable {
    
    func key(for value: Value) -> Key? {
        
        return compactMap { value == $1 ? $0 : nil }.first
    }
}

