//
//  FiltersController.swift
//  MTG Sets and Cards
//
//  Created by António Ramos on 06/10/2019.
//  Copyright © 2019 ARdev. All rights reserved.
//

import UIKit

protocol FiltersControllerDelegate: class {
    func filtersController(didApplyFiltersIn array: [MtgSet])
}

class FiltersController: UIViewController {
    
    
    @IBOutlet weak var newPicker: UIPickerView!
    @IBOutlet weak var newToolBar: UIToolbar!
    
    @IBOutlet weak var mainView: UIView! {
        didSet {
            mainView.applyLayerStyle(
                cornerRadius: 8,
                borderWidth: 1,
                borderColor: UIColor.gray.withAlphaComponent(0.4).cgColor
            )
        }
    }
    @IBOutlet weak var backgroundImageView: UIImageView! {
        didSet {
            backgroundImageView.applyLayerStyle(
                cornerRadius: 8,
                borderWidth: 0,
                borderColor: UIColor.clear.cgColor
            )
        }
    }
    

    @IBOutlet weak var setNameTextField: UITextField!
    @IBOutlet weak var yeartFirstTextField: UITextField!
    @IBOutlet weak var yearSecondTextField: UITextField!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var languageTextField: UITextField! {
        didSet {
            languageTextField.text = languages[languageCurrentlySelected]
        }
    }
    
    var stringText = [100, 120, 130, 140, 150]
    var collectionOfSets: [MtgSet] = []
    var releaseYears: [Int] {
        return (collectionOfSets.map {$0.releaseDate.returnYearFromDate()}).removeDuplicates()
    }
    var setNames: [String] {
        return collectionOfSets.map {$0.name}
    }
    
    weak var delegate: FiltersControllerDelegate?
    
    var picker = UIPickerView()
    let toolbar = UIToolbar()
    var activeTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newToolBar.isHidden = true
        newPicker.isHidden = true
        setOkButtonState()
        [setNameTextField, yeartFirstTextField, yearSecondTextField, languageTextField].forEach{
            $0?.delegate = self
            $0?.textColor = .white
            $0?.font = UIFont.belerenMedium
            $0?.keyboardAppearance = .dark
            $0?.inputView = newPicker
            $0?.inputAccessoryView = newToolBar
        }
        setupPickerView()
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okButton(_ sender: Any) {
        
        delegate?.filtersController(didApplyFiltersIn: filter())
        UserDefaults.standard.set(languages.key(for: languageTextField.text!), forKey: "Cards Language")
        dismiss(animated: true, completion: nil)
    }
    
   
    
    func setupPickerView() {
        newPicker.delegate = self
        newPicker.dataSource = self
        newPicker.delegate?.pickerView?(newPicker, didSelectRow: 0, inComponent: 0)
        newPicker.setValue(UIColor.clear, forKey: "backgroundColor")
        newPicker.setValue(UIColor.white, forKey: "textColor")
        newPicker.alpha = 0.7
    }
    
    @objc func okToolbarButtonTapped() {
        view.endEditing(true)
    }
    
    @objc func cancelToolbarButtonTapped() {
        view.endEditing(true)
        activeTextField?.text = ""
        setOkButtonState()
    }
    
   
    func setOkButtonState() {
        for textField in [setNameTextField, yeartFirstTextField, yearSecondTextField] {
            if textField!.text == "" {
                okButton.isEnabled = false
            } else {
                okButton.isEnabled = true
                break
            }
        }
    }
    
    func filter() -> [MtgSet]{
        
        var filteredArray: [MtgSet] = []
        
        if yeartFirstTextField.text != "" && yearSecondTextField.text != "" {
            
            if let firstChoosenYear = Int(yeartFirstTextField.text!), let secondChoosenYear = Int(yearSecondTextField.text!) {
                let range = firstChoosenYear...secondChoosenYear
                
                collectionOfSets.forEach {
                    if range.contains($0.releaseDate.returnYearFromDate()) {
                        filteredArray.append($0)
                        
                    }
                }
            }
        } else if yeartFirstTextField.text != "" {
            
            if let year = Int(yeartFirstTextField.text!) {
                collectionOfSets.forEach {
                    if $0.releaseDate.returnYearFromDate() == year {
                        filteredArray.append($0)
                    }
                }
            }
        } else if setNameTextField.text != "" {
            if let setName = setNameTextField.text {
                collectionOfSets.forEach {
                    if $0.name == setName {
                        filteredArray.append($0)
                    }
                }
            }
        } else {
            
        }
        return filteredArray
    }
}


extension FiltersController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        newToolBar.isHidden = false
        newPicker.isHidden = false
        activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        newToolBar.isHidden = true
        newPicker.isHidden = true
        setOkButtonState()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == yeartFirstTextField || textField == yearSecondTextField {
            let allowedCharacters = CharacterSet(charactersIn: "0123456789")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        } else {
            return true
        }
    }
}

extension FiltersController: UIPickerViewDelegate, UIPickerViewDataSource {
    
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        var choosenValue = ""
        
        if activeTextField == yeartFirstTextField || activeTextField == yearSecondTextField {
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
