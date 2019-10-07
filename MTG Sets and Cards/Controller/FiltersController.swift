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
    
    @IBOutlet weak var languageButton: UIButton!
    @IBOutlet weak var setNameTextField: UITextField!
    @IBOutlet weak var yeartFirstTextField: UITextField!
    @IBOutlet weak var yearSecondTextField: UITextField!
    @IBOutlet weak var okButton: UIButton!
    
    var stringText = [100, 120, 130, 140, 150]
    var collectionOfSets: [MtgSet] = []
    var filteredCollectionOfSets: [MtgSet] = []
    var releaseYears: [Int] {
        return (collectionOfSets.map {$0.releaseDate.returnYearFromDate()}).removeDuplicates()
    }
    
    weak var delegate: FiltersControllerDelegate?
    
    var picker = UIPickerView()
    let toolbar = UIToolbar()
    var activeTextField: UITextField?
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setOkButtonState()
        [setNameTextField, yeartFirstTextField, yearSecondTextField].forEach{
            $0?.delegate = self
            $0?.font = UIFont.belerenSmall
            $0?.keyboardAppearance = .dark
            $0?.inputView = picker
            $0?.inputAccessoryView = toolbar
        }
        setupPickerView()
        setupPickerToolBar()
    }
    
    @IBAction func chooseLanguageButton(_ sender: Any) {
        
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okButton(_ sender: Any) {
        
        delegate?.filtersController(didApplyFiltersIn: filteredCollectionOfSets)
    }
    
    func setupPickerView() {
        picker.delegate = self
        picker.dataSource = self
        picker.delegate?.pickerView?(picker, didSelectRow: 0, inComponent: 0)
        picker.setValue(UIColor.clear, forKey: "backgroundColor")
        picker.setValue(UIColor.white, forKey: "textColor")
        picker.alpha = 0.7
    }
    
    func setupPickerToolBar() {
        
        toolbar.sizeToFit()
        let okButton = UIBarButtonItem(title: "Ok", style: .done, target: self, action: #selector(okToolbarButtonTapped))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelToolbarButtonTapped))
        toolbar.setItems([cancelButton, flexSpace, okButton], animated: true)
        
        [cancelButton, okButton].forEach{
            $0.setAppearance(with: .belerenSmall, color: .white, for: .normal)
            $0.setAppearance(with: .belerenSmall, color: .darkGray, for: .highlighted)
            
        }
        toolbar.isUserInteractionEnabled = true
        
    }
    
    @objc func okToolbarButtonTapped() {
        view.endEditing(true)
    }
    
    @objc func cancelToolbarButtonTapped() {
        view.endEditing(true)
        activeTextField?.text = ""
        setOkButtonState()
    }
    
    private func setupFilteredArray() {
        //if [setNameTextField, yeartFirstTextField, yearSecondTextField].for
        
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
}

extension FiltersController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("call")
        setOkButtonState()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
}

extension FiltersController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return releaseYears.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(releaseYears[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let choosenValue = releaseYears[pickerView.selectedRow(inComponent: 0)]
        activeTextField?.text = String(choosenValue)
        pickerView.resignFirstResponder()
    }
    
}
