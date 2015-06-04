//
//  FormPickerCell.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 22/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

class FormPickerCell: FormValueCell, UIPickerViewDelegate, UIPickerViewDataSource {
    
    /// MARK: Properties
    
    private let picker = UIPickerView()
    private let hiddenTextField = UITextField(frame: CGRectZero)
    
    /// MARK: FormBaseCell
    
    override func configure() {
        super.configure()
        accessoryType = .None
        
        picker.delegate = self
        picker.dataSource = self
        hiddenTextField.inputView = picker
        
        contentView.addSubview(hiddenTextField)
    }
    
    override func update() {
        super.update()
        
        titleLabel.text = rowDescriptor.title
        
        if rowDescriptor.value != nil {
            valueLabel.text = rowDescriptor.titleForOptionValue(rowDescriptor.value)
        }
    }
    
    override class func formViewController(formViewController: FormViewController, didSelectRow selectedRow: FormBaseCell) {
        
        if selectedRow.rowDescriptor.value == nil {
            if let row = selectedRow as? FormPickerCell {
                let options = selectedRow.rowDescriptor.configuration[FormRowDescriptor.Configuration.Options] as? NSArray
                let optionValue = options?[0] as? NSObject
                selectedRow.rowDescriptor.value = optionValue
                row.valueLabel.text = selectedRow.rowDescriptor.titleForOptionValue(optionValue!)
                row.hiddenTextField.becomeFirstResponder()
            }
        } else {
			if let row = selectedRow as? FormPickerCell {
                let optionValue = selectedRow.rowDescriptor.value
                row.valueLabel.text = selectedRow.rowDescriptor.titleForOptionValue(optionValue)
                row.hiddenTextField.becomeFirstResponder()
            }
		}
    }
    
    /// MARK: UIPickerViewDelegate
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return rowDescriptor.titleForOptionAtIndex(row)
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let options = rowDescriptor.configuration[FormRowDescriptor.Configuration.Options] as? NSArray
        let optionValue = options?[row] as? NSObject
        rowDescriptor.value = optionValue
        valueLabel.text = rowDescriptor.titleForOptionValue(optionValue!)
    }
    
    /// MARK: UIPickerViewDataSource
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if let options = rowDescriptor.configuration[FormRowDescriptor.Configuration.Options] as? NSArray {
            return options.count
        }
        return 0
    }
}
