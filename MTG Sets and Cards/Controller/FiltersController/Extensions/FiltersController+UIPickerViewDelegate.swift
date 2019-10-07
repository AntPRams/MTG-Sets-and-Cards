//
//  FiltersController+UIPickerViewDelegate.swift
//  MTG Sets and Cards
//
//  Created by António Ramos on 07/10/2019.
//  Copyright © 2019 ARdev. All rights reserved.
//

import UIKit

extension FiltersController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        var choosenValue = ""
        
        if activeTextField == yearFstEntryTxtField || activeTextField == yearScdEntryTextField {
            choosenValue = String(releaseYears[pickerView.selectedRow(inComponent: 0)])
        } else if activeTextField == setNameTextField {
            choosenValue = setNames[pickerView.selectedRow(inComponent: 0)]
        } else {
            choosenValue = Array(languages.values)[pickerView.selectedRow(inComponent: 0)]
        }

        activeTextField?.text = choosenValue
        pickerView.resignFirstResponder()
    }
    
}
