//
//  FormSwitchCell.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 21/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

class FormSwitchCell: FormTitleCell {

    /// MARK: Cell views
    
    let switchView = UISwitch()
    
    /// MARK: FormBaseCell
    
    override func configure() {
        super.configure()
        
        selectionStyle = .None
        
        switchView.addTarget(self, action: "valueChanged:", forControlEvents: .ValueChanged)
        accessoryView = switchView
    }
    
    override func update() {
        super.update()
        
        titleLabel.text = rowDescriptor.title
        titleLabel.numberOfLines = 4;
        titleLabel.font = UIFont(name: "Helvetica Neue", size:15.0);
        if rowDescriptor.value != nil {
            switchView.on = rowDescriptor.value as! Bool
        }
        else {
            switchView.on = false
            rowDescriptor.value = false
        }
    }
    
    /// MARK: Actions
    
    func valueChanged(_: UISwitch) {
        rowDescriptor.value = switchView.on as! Bool
    }
}
