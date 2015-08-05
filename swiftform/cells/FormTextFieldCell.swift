//
//  FormTextFieldCell.swift
//  SwiftForms
//
//  Created by Miguel Ángel Ortuño Ortuño on 20/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

class FormTextFieldCell: FormBaseCell,UITextFieldDelegate {

    /// MARK: Cell views
    
    let titleLabel = UILabel()
    let textField = UITextField()
    
    /// MARK: Properties
    
    private var customConstraints: [AnyObject]!
    
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
        titleLabel.setContentCompressionResistancePriority(1000, forAxis: .Horizontal)
        
        contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Height, relatedBy: .Equal, toItem: contentView, attribute: .Height, multiplier: 1.0, constant: 0.0))
        contentView.addConstraint(NSLayoutConstraint(item: textField, attribute: .Height, relatedBy: .Equal, toItem: contentView, attribute: .Height, multiplier: 1.0, constant: 0.0))
        contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .CenterY, relatedBy: .Equal, toItem: contentView, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        contentView.addConstraint(NSLayoutConstraint(item: textField, attribute: .CenterY, relatedBy: .Equal, toItem: contentView, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        
        
        var leftMarginConstraint:NSLayoutConstraint = NSLayoutConstraint(item: self.textField, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 120)
        
        
        contentView.addConstraint(leftMarginConstraint)
        
        
        textField.delegate = self
        
        
        textField.addTarget(self, action: "editingChanged:", forControlEvents: .EditingChanged)
        
    }
    
    override func update() {
        super.update()
        
        if let showsInputToolbar = rowDescriptor.configuration[FormRowDescriptor.Configuration.ShowsInputToolbar] as? Bool {
            if showsInputToolbar && textField.inputAccessoryView == nil {
                textField.inputAccessoryView = inputAccesoryView()
            }
        }
    
        titleLabel.text = rowDescriptor.title
        textField.text = rowDescriptor.value as? String
        textField.placeholder = rowDescriptor.configuration[FormRowDescriptor.Configuration.Placeholder] as? String
        textField.returnKeyType = .Next
        textField.secureTextEntry = false
        textField.clearButtonMode = .WhileEditing
        
        switch rowDescriptor.rowType {
        case .Text:
            textField.autocorrectionType = .Default
            textField.autocapitalizationType = .Sentences
            textField.keyboardType = .Default
        case .Number:
            textField.keyboardType = .NumberPad
        case .NumbersAndPunctuation:
            textField.keyboardType = .NumbersAndPunctuation
        case .Decimal:
            textField.keyboardType = .DecimalPad
        case .Name:
            textField.autocorrectionType = .No
            textField.autocapitalizationType = .Words
            textField.keyboardType = .Default
        case .Phone:
            textField.keyboardType = .PhonePad
        case .NamePhone:
            textField.autocorrectionType = .No
            textField.autocapitalizationType = .Words
            textField.keyboardType = .NamePhonePad
        case .URL:
            textField.autocorrectionType = .No
            textField.autocapitalizationType = .None
            textField.keyboardType = .URL
        case .Twitter:
            textField.autocorrectionType = .No
            textField.autocapitalizationType = .None
            textField.keyboardType = .Twitter
        case .Email:
            textField.autocorrectionType = .No
            textField.autocapitalizationType = .None
            textField.keyboardType = .EmailAddress
        case .ASCIICapable:
            textField.autocorrectionType = .No
            textField.autocapitalizationType = .None
            textField.keyboardType = .ASCIICapable
        case .Password:
            textField.secureTextEntry = true
            textField.clearsOnBeginEditing = false
        default:
            break
        }
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
    
    override func firstResponderElement() -> UIResponder? {
        return textField
    }
    
    override class func formRowCanBecomeFirstResponder() -> Bool {
        return true
    }
    
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    {
        if textField.keyboardType == .PhonePad
        {
            var newString = (textField.text as NSString).stringByReplacingCharactersInRange(range, withString: string)
            var components = newString.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet)
            
            var decimalString = "".join(components) as NSString
            var length = decimalString.length
            var hasLeadingOne = length > 0 && decimalString.characterAtIndex(0) == (1 as unichar)
            
            if length == 0 || (length > 10 && !hasLeadingOne) || length > 11
            {
                var newLength = (textField.text as NSString).length + (string as NSString).length - range.length as Int
                
                return (newLength > 10) ? false : true
            }
            var index = 0 as Int
            var formattedString = NSMutableString()
            
            if hasLeadingOne
            {
                formattedString.appendString("1 ")
                index += 1
            }
            if (length - index) > 3
            {
                var areaCode = decimalString.substringWithRange(NSMakeRange(index, 3))
                formattedString.appendFormat("(%@)", areaCode)
                index += 3
            }
            if length - index > 3
            {
                var prefix = decimalString.substringWithRange(NSMakeRange(index, 3))
                formattedString.appendFormat("%@-", prefix)
                index += 3
            }
            
            var remainder = decimalString.substringFromIndex(index)
            formattedString.appendString(remainder)
            textField.text = formattedString
            rowDescriptor.value = formattedString
            return false
        }
        else
        {
            return true
        }
    }
    
/// MARK: Actions
    
    func editingChanged(sender: UITextField) {
        let trimmedText = sender.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        rowDescriptor.value = countElements(trimmedText) > 0 ? trimmedText : nil
    }
    
    
    
    
}
