//
//  FormTitleCell.swift
//  SwiftForms
//
//  Created by Miguel Ángel Ortuño Ortuño on 13/11/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

class FormTitleCell: FormBaseCell {

    /// MARK: Cell views
    
    let titleLabel = UILabel()
    var heightconstraint : NSLayoutConstraint!
    
    var centerYconstraint : NSLayoutConstraint!
    /// MARK: FormBaseCell
    
    override func configure() {
        super.configure()
        
        titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        titleLabel.font = UIFont(name: "GothamRounded-Medium", size:15.0);
        
        // apply constant constraints
        contentView.addSubview(titleLabel)
        heightconstraint = NSLayoutConstraint(item: titleLabel, attribute: .Height, relatedBy: .Equal, toItem: contentView, attribute: .Height, multiplier: 1.0, constant: 0.0)
        
        contentView.addConstraint(heightconstraint)
        centerYconstraint = NSLayoutConstraint(item: titleLabel, attribute: .CenterY, relatedBy: .Equal, toItem: contentView, attribute: .CenterY, multiplier: 1.0, constant: 0.0)
        contentView.addConstraint(centerYconstraint)
    }
    
    override func constraintsViews() -> [String : UIView] {
        return ["titleLabel" : titleLabel]
    }
    
    override func defaultVisualConstraints() -> [String] {
        return ["H:|-16-[titleLabel]-16-|"]
    }
}
