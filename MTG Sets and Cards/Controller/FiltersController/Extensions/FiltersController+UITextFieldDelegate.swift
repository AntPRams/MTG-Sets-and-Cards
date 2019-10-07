//
//  FiltersController+UITextFieldDelegate.swift
//  MTG Sets and Cards
//
//  Created by António Ramos on 07/10/2019.
//  Copyright © 2019 ARdev. All rights reserved.
//

import UIKit

extension FiltersController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        newToolBar.isHidden = false
        newPicker.isHidden = false
        activeTextField = textField
        disableAllComponents(exception: textField, shouldEnable: false)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        newToolBar.isHidden = true
        newPicker.isHidden = true
        disableAllComponents(exception: textField, shouldEnable: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == yearFstEntryTxtField || textField == yearScdEntryTextField {
            let allowedCharacters = CharacterSet(charactersIn: "0123456789")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        } else {
            return true
        }
    }
    
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
}
