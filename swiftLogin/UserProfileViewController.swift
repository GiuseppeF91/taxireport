//
//  ExampleFormViewController.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 20/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit
class UserProfileViewController: FormViewController, FormViewControllerDelegate {
    
    struct Static {
        static let nameTag = "name"
        static let passwordTag = "password"
        static let lastNameTag = "lastName"
        static let jobTag = "job"
        static let emailTag = "email"
        static let URLTag = "url"
        static let phoneTag = "phone"
        static let enabled = "enabled"
        static let check = "check"
        static let segmented = "segmented"
        static let picker = "picker"
        static let birthday = "birthday"
        static let categories = "categories"
        static let button = "button"
        static let textView = "textview"
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadForm()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden = false
        
        self.delegate = self
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .Bordered, target: self, action: "done:")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Bordered, target: self, action: "cancel:")
        
    }
    
    /// MARK: Actions
    
    func done(_: UIBarButtonItem!) {
        var destViewController : MyNavigationController
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        
        destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("mynav") as! MyNavigationController
        
       
        var appdelegate : AppDelegate
        
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appdelegate.window?.rootViewController = destViewController;
        
        
    }
    
    func cancel(_: UIBarButtonItem!) {
        self.navigationController?.popViewControllerAnimated(true)
/*
        let message = self.form.formValues().description
        
        let alert: UIAlertView = UIAlertView(title: "Form output", message: message, delegate: nil, cancelButtonTitle: "OK")
        
        alert.show()*/
    }
    
    /// MARK: Private interface
    
    private func loadForm() {
        
        let form = FormDescriptor()
        
        form.title = "Profile"
        
        let section1 = FormSectionDescriptor()
        
        var row : FormRowDescriptor! = FormRowDescriptor (tag: Static.nameTag, rowType: .Name, title: "First Name")
        
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "Cosmo", "textField.textAlignment" : NSTextAlignment.Left.rawValue]
        section1.addRow(row)
        
        row = FormRowDescriptor(tag: Static.lastNameTag, rowType: .Name, title: "Last Name")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "Kramer", "textField.textAlignment" : NSTextAlignment.Left.rawValue]
        section1.addRow(row)
        
        
        row = FormRowDescriptor(tag: Static.emailTag, rowType: .Email, title: "Email")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "cosmo.kramer@email.com", "textField.textAlignment" : NSTextAlignment.Left.rawValue]
        section1.addRow(row)
        
        row = FormRowDescriptor(tag: Static.passwordTag, rowType: .Password, title: "Password")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "Enter password", "textField.textAlignment" : NSTextAlignment.Left.rawValue]
        section1.addRow(row)
        
        
        row = FormRowDescriptor(tag: Static.phoneTag, rowType: .Phone, title: "Phone #")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "212-555-3455", "textField.textAlignment" : NSTextAlignment.Left.rawValue]
        section1.addRow(row)
        
        row = FormRowDescriptor(tag: Static.picker, rowType: .Picker, title: "Borough")
        row.configuration[FormRowDescriptor.Configuration.Options] = ["A", "B", "C"]
        row.configuration[FormRowDescriptor.Configuration.TitleFormatterClosure] = { value in
            switch( value ) {
            case "A":
                return "New work"
            case "B":
                return "Beijing"
            case "C":
                return "Tieling"
            default:
                return nil
            }
            } as TitleFormatterClosure
        
        section1.addRow(row)
        
        
        
        row = FormRowDescriptor(tag: Static.jobTag, rowType: .Text, title: "Building #")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "129", "textField.textAlignment" : NSTextAlignment.Left.rawValue]
        section1.addRow(row)
        
        
        
        row = FormRowDescriptor(tag: Static.URLTag, rowType: .URL, title: "Street Name")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "W. 81st Street", "textField.textAlignment" : NSTextAlignment.Left.rawValue]
        section1.addRow(row)
        
        row = FormRowDescriptor(tag: Static.URLTag, rowType: .URL, title: "Apt #")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "5A", "textField.textAlignment" : NSTextAlignment.Left.rawValue]
        section1.addRow(row)
        
        
        
        
        row = FormRowDescriptor(tag: Static.enabled, rowType: .BooleanSwitch, title: "I'm willing to testify at a hearing?( About x% of complaints end up going to trial.) You can testify by phone.")
        section1.addRow(row)
        
        
        
        form.sections = [section1]
        
        self.form = form
    }
    
    /// MARK: FormViewControllerDelegate
    
    func formViewController(controller: FormViewController, didSelectRowDescriptor rowDescriptor: FormRowDescriptor) {
        if rowDescriptor.tag == Static.button {
            self.view.endEditing(true)
        }
    }
}
