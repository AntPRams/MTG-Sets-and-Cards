//
//  StringExtension.swift
//  MTG Sets and Cards
//
//  Created by António Ramos on 06/10/2019.
//  Copyright © 2019 ARdev. All rights reserved.
//

import Foundation

//Helpers to deal with set release date and to deal with the promo sets in order to retrive the correct set icon and avoid repeating images in assets

extension String {
    
    private func convertStringToDate(_ isoDate: String) -> Date {
        let isoDate = isoDate
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd-MM-yyyy"
        dateFormatterGet.locale = NSLocale.current
        guard let date = dateFormatterGet.date(from: isoDate) else {return Date()}
        return date
    }
    
    func dateFormatModifier(dateFormat: String) -> String{
        
        let dateFormatterSet = DateFormatter()
        dateFormatterSet.dateFormat = dateFormat
        
        let dateToPresent = convertStringToDate(self)
        
        return dateFormatterSet.string(from: dateToPresent)
    }
  
    func returnYearFromDate() -> Int {
        
        let date = convertStringToDate(self)
        guard let year = Calendar.current.dateComponents([.year], from: date).year else {return 0}
        
        return year
    }
    
    func identifyPromoSets(setName: String) -> String{
        if setName.localizedCaseInsensitiveContains("promo") && self.hasPrefix("p") {
            return String(self.dropFirst())
        } else {
            return self
        }
    }
}
