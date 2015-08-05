//
//  FormSelectorCell.swift
//  SwiftForms
//
//  Created by Miguel Ángel Ortuño Ortuño on 23/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

class FormSelectorCell: FormValueCell {
    
    /// MARK: FormBaseCell
    
    override func update() {
        super.update()
        
        titleLabel.text = rowDescriptor.title

        var title: String!
        
        if let selectedValues = rowDescriptor.value as? NSMutableArray { // multiple values
            
            let indexedSelectedValues = NSSet(array: selectedValues)
            
            if let options = rowDescriptor.configuration[FormRowDescriptor.Configuration.Options] as? NSArray {
                for optionValue in options {
                    if indexedSelectedValues.containsObject(optionValue) {
                        let optionTitle = rowDescriptor.titleForOptionValue(optionValue as NSObject)
                        if title != nil {
                            title = title + ", \(optionTitle)"
                        }
                        else {
                            title = optionTitle
                        }
                    }
                }
            }
        }
        else if let selectedValue = rowDescriptor.value { // single value
            title = rowDescriptor.titleForOptionValue(selectedValue)
        }
        
        if title != nil && countElements(title) > 0 {
            valueLabel.text = title
            valueLabel.textColor = UIColor.blackColor()
        }
        else {
            valueLabel.text = rowDescriptor.configuration[FormRowDescriptor.Configuration.Placeholder] as? String
            valueLabel.textColor = UIColor.lightGrayColor()
        }
    }
    
    override class func formViewController(formViewController: FormViewController, didSelectRow selectedRow: FormBaseCell) {
        if let row = selectedRow as? FormSelectorCell {
            
            formViewController.view.endEditing(true)
            
            var selectorClass: UIViewController.Type!
            
            if let selectorControllerClass: AnyClass = row.rowDescriptor.configuration[FormRowDescriptor.Configuration.SelectorControllerClass] as? AnyClass {
                selectorClass = selectorControllerClass as? UIViewController.Type
            }
            else { // fallback to default cell class
                selectorClass = FormOptionsSelectorController.self
            }
            
            if selectorClass != nil {
                let selectorController = selectorClass()
                if let formRowDescriptorViewController = selectorController as? FormSelector {
                    formRowDescriptorViewController.formCell = row
                    formViewController.navigationController?.pushViewController(selectorController, animated: true)
                }
                else {
                    fatalError("FormRowDescriptor.Configuration.SelectorControllerClass must conform to FormSelector protocol.")
                }
            }
        }
    }
}
