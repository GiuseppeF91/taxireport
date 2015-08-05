//
//  FormButtonCell.swift
//  SwiftForms
//
//  Created by Jun Lee on 21/08/14.
//  Copyright (c) 2014 Jun Lee. All rights reserved.
//

import UIKit

class FormButtonCell: FormTitleCell {
    
    /// MARK: FormBaseCell
    
    override func configure() {
        super.configure()
        titleLabel.textAlignment = .Center
    }
    
    override func update() {
        super.update()
        titleLabel.text = rowDescriptor.title as! String
    }
}
