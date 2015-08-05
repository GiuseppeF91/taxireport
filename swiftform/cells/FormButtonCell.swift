//
//  FormButtonCell.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 21/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

class FormButtonCell: FormTitleCell {
    
    /// MARK: FormBaseCell
    
    override func configure() {
        super.configure()
        titleLabel.textAlignment = .Center
        titleLabel.numberOfLines = 0
        contentView.backgroundColor = UIColor(red: 0.917, green: 0.917, blue: 0.917, alpha: 1.0)
        
        
        var leftMarginConstraint:NSLayoutConstraint = NSLayoutConstraint(item: self.titleLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 20)
        
        
        var rightMarginConstraint:NSLayoutConstraint = NSLayoutConstraint(item: self.titleLabel, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 20)
        
        
        
        
        contentView.addConstraints([leftMarginConstraint, rightMarginConstraint])

        
        
        
    }
    
    override func update() {
        super.update()
        titleLabel.text = rowDescriptor.title as String
    }
}
