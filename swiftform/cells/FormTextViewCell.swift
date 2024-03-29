//
//  FormTextViewCell.swift
//  SwiftForms
//
//  Created by Joey Padot on 12/6/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

class FormTextViewCell : FormBaseCell, UITextViewDelegate {
    /// MARK: Cell views
    
    let titleLabel = UILabel()
    let textField = UITextView()
    
    /// MARK: Properties
    
    private var customConstraints: [AnyObject]!
    
    /// MARK: Class Funcs
    override class func formRowCellHeight() -> CGFloat {
        return 110.0
    }
    
    /// MARK: FormBaseCell
    
    override func configure() {
        super.configure()
        
        selectionStyle = .None
        
        titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        textField.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        titleLabel.font = UIFont(name: "GothamRounded-Medium", size:15.0);
        textField.font = UIFont(name: "GothamRounded-Medium", size:15.0);
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(textField)
        
        titleLabel.setContentHuggingPriority(500, forAxis: .Horizontal)
        
        contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Height, relatedBy: .Equal, toItem: contentView, attribute: .Height, multiplier: 1.0, constant: 0.0))
        contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .CenterY, relatedBy: .Equal, toItem: contentView, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        contentView.addConstraint(NSLayoutConstraint(item: textField, attribute: .Top, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1.0, constant: 0.0))
        contentView.addConstraint(NSLayoutConstraint(item: textField, attribute: .Bottom, relatedBy: .Equal, toItem: contentView, attribute: .Bottom, multiplier: 1.0, constant: 0.0))
        
        textField.delegate = self
    }
    
    override func update() {
        
        titleLabel.text = rowDescriptor.title
        textField.text = rowDescriptor.value as? String
        
        textField.secureTextEntry = false
        textField.autocorrectionType = .Default
        textField.autocapitalizationType = .Sentences
        textField.keyboardType = .Default
    }
    
    override func constraintsViews() -> [String : UIView] {
        var views = ["titleLabel" : titleLabel, "textField" : textField]
        if self.imageView!.image != nil {
            views["imageView"] = imageView
        }
        return views
    }
    
    override func defaultVisualConstraints() -> [String] {
        
        if self.imageView!.image != nil {
            
            if titleLabel.text != nil && countElements(titleLabel.text!) > 0 {
                return ["H:[imageView]-[titleLabel]-[textField]-16-|"]
            }
            else {
                return ["H:[imageView]-[textField]-16-|"]
            }
        }
        else {
            if titleLabel.text != nil && countElements(titleLabel.text!) > 0 {
                return ["H:|-16-[titleLabel]-[textField]-16-|"]
            }
            else {
                return ["H:|-16-[textField]-16-|"]
            }
        }
    }
    
    /// MARK: UITextViewDelegate
    func textViewDidEndEditing(textView: UITextView) {
        rowDescriptor.value = textView.text
    }
}
