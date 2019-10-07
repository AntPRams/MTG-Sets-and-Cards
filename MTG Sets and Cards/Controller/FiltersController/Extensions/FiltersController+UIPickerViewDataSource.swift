//
//  FiltersController+UIPickerViewDataSource.swift
//  MTG Sets and Cards
//
//  Created by António Ramos on 07/10/2019.
//  Copyright © 2019 ARdev. All rights reserved.
//

import UIKit

extension FiltersController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if activeTextField == yeartFirstTextField || activeTextField == yearSecondTextField {
            return releaseYears.count
        } else if activeTextField == setNameTextField {
            return setNames.count
        } else {
            return languages.values.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if activeTextField == yeartFirstTextField || activeTextField == yearSecondTextField {
            return String(releaseYears[row])
        } else if activeTextField == setNameTextField {
            return setNames[row]
        } else {
            return Array(languages.values)[row]
        }
    }
}
