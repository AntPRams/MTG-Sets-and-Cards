//
//  StringExtension.swift
//  MTG Sets and Cards
//
//  Created by António Ramos on 06/10/2019.
//  Copyright © 2019 ARdev. All rights reserved.
//

import Foundation

extension String {
    
    func dateFormatModifier(dateFormat: String) -> String{
        
        let isoDate = self
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd-MM-yyyy"
        dateFormatterGet.locale = NSLocale.current
        let date = dateFormatterGet.date(from: isoDate)
        
        let dateFormatterSet = DateFormatter()
        dateFormatterSet.dateFormat = dateFormat
        
        let dateToPresent = date!
        
        return dateFormatterSet.string(from: dateToPresent)
        
        
    }
    
    func toFormattedDate(stringDate: String, withFormat format: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: self) else {return ""}
        
        return dateFormatter.string(from: date)
    }
    
    func identifyPromoSets(setName: String) -> String{
        if setName.localizedCaseInsensitiveContains("promo") && self.hasPrefix("p") {
            return String(self.dropFirst())
        } else {
            return self
        }
    }
}
