//
//  StringExtension.swift
//  MTG Sets and Cards
//
//  Created by António Ramos on 06/10/2019.
//  Copyright © 2019 ARdev. All rights reserved.
//

import Foundation

extension String {
    
    func toFormattedDate(withFormat format: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: self) else {return ""}
        
        return dateFormatter.string(from: date)
    }
}
