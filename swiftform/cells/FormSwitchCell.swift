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
        switchView.frame = CGRectMake(15, 25, 51, 31)
        contentView.addSubview(switchView)
        
        
        
        var leftMarginConstraint:NSLayoutConstraint = NSLayoutConstraint(item: self.titleLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 81)

        
        contentView.addConstraint(leftMarginConstraint)
        
        
        
    }
    
    override func update() {
        super.update()
        
        titleLabel.text = rowDescriptor.title
        titleLabel.numberOfLines = 4;
        titleLabel.font = UIFont(name: "GothamRounded-Medium", size:14.0);
        if rowDescriptor.value != nil {
            switchView.on = rowDescriptor.value as Bool
        }
        else {
            switchView.on = true
            rowDescriptor.value = true
        }
    }
    
    /// MARK: Actions
    
    func valueChanged(_: UISwitch) {
        rowDescriptor.value = switchView.on as Bool
    }
}
