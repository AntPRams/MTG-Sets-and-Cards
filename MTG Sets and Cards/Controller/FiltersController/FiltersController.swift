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
    
    //MARK: Outlets
    
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
    
    @IBOutlet weak var languageTextField: UITextField! {
        didSet {
            languageTextField.text = languages[UserDefaults.standard.string(forKey: "Cards Language")!]
        }
    }
    
    @IBOutlet weak var okBarButton: UIBarButtonItem! {
        didSet {
            okBarButton.setAppearance(with: UIFont.belerenSmall, color: UIColor.white, for: .normal)
            okBarButton.setAppearance(with: UIFont.belerenSmall, color: UIColor.lightGray, for: .highlighted)
        }
    }
    @IBOutlet weak var cancelBarButton:     UIBarButtonItem! {
        didSet {
            cancelBarButton.setAppearance(with: UIFont.belerenSmall, color: UIColor.darkGray, for: .normal)
            cancelBarButton.setAppearance(with: UIFont.belerenSmall, color: UIColor.lightGray, for: .highlighted)
        }
    }
    @IBOutlet weak var newPicker:             UIPickerView!
    @IBOutlet weak var newToolBar:            UIToolbar!
    @IBOutlet weak var setNameTextField:      UITextField!
    @IBOutlet weak var yearFstEntryTxtField:  UITextField!
    @IBOutlet weak var yearScdEntryTextField: UITextField!
    @IBOutlet weak var okButton:              UIButton!
    @IBOutlet weak var cancelButton:          UIButton!
    
    //MARK: Properties
    
    var collectionOfSets: [MtgSet] = []
    var releaseYears: [Int] {
        return (collectionOfSets.map {$0.releaseDate.returnYearFromDate()}).removeDuplicates()
    }
    var setNames: [String] {
        return (collectionOfSets.map {$0.name}).sorted()
    }
    
    
    weak var delegate: FiltersControllerDelegate?
    var picker = UIPickerView()
    let toolbar = UIToolbar()
    var activeTextField: UITextField?
    
    //MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newToolBar.isHidden = true
        newPicker.isHidden = true
        [setNameTextField, yearFstEntryTxtField, yearScdEntryTextField, languageTextField].forEach{
            $0?.delegate = self
            $0?.textColor = .white
            $0?.font = UIFont.belerenMedium
            $0?.keyboardAppearance = .dark
            $0?.inputView = newPicker
            $0?.inputAccessoryView = newToolBar
        }
        yearScdEntryTextField.isUserInteractionEnabled = yearFstEntryTxtField.text == "" ? false : true
        setupPickerView()
    }
    
    //MARK: Actions
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okButton(_ sender: Any) {
        
        if filter().count == 0 && UserDefaults.standard.string(forKey: "Cards Language") == languages.key(for: languageTextField.text!){
            presentAlert(message: "Your search did not return any result, please try again")
            return
        }
        
        delegate?.filtersController(didApplyFiltersIn: filter())
        UserDefaults.standard.set(languages.key(for: languageTextField.text!), forKey: "Cards Language")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okOnBarButtonTapped(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func cancelOnBarButtonTapped(_ sender: Any) {
        view.endEditing(true)
        activeTextField?.text = ""
    }
    
    //MARK: Methods
   
    private func setupPickerView() {
        newPicker.delegate = self
        newPicker.dataSource = self
        newPicker.delegate?.pickerView?(newPicker, didSelectRow: 0, inComponent: 0)
        newPicker.setValue(UIColor.clear, forKey: "backgroundColor")
        newPicker.setValue(UIColor.white, forKey: "textColor")
        newPicker.alpha = 0.7
    }
    
    private func filter() -> [MtgSet]{
        
        var filteredArray: [MtgSet] = []
        
        if yearFstEntryTxtField.text != "" && yearScdEntryTextField.text != "" {
            
            if let firstChoosenYear = Int(yearFstEntryTxtField.text!), let secondChoosenYear = Int(yearScdEntryTextField.text!) {
                
                let range = firstChoosenYear < secondChoosenYear ? firstChoosenYear...secondChoosenYear : secondChoosenYear...firstChoosenYear
                
                collectionOfSets.forEach {
                    if range.contains($0.releaseDate.returnYearFromDate()) {
                        filteredArray.append($0)
                        
                    }
                }
            }
        } else if yearFstEntryTxtField.text != "" {
            
            if let year = Int(yearFstEntryTxtField.text!) {
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
    
    func disableAllComponents(exception: UITextField, shouldEnable: Bool) {
        
        let uiComponents = [yearFstEntryTxtField, yearScdEntryTextField, okButton, cancelButton, languageTextField, setNameTextField]
        
        for component in uiComponents {
            if component == exception {
                continue
            } else {
                component?.isUserInteractionEnabled = shouldEnable
                yearScdEntryTextField.isUserInteractionEnabled = yearFstEntryTxtField.text == "" ? false : true
            }
        }
    }
}





