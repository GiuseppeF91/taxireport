//
//  ExampleFormViewController.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 20/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit
class UserProfileViewController: FormViewController, FormViewControllerDelegate {
    
    
    var transitionOperator = TransitionOperator()
    
    struct Static {
        static let nameTag = "name"
        static let lastNameTag = "lastName"
        static let buildingtag = "job"
        static let emailTag = "email"
        static let streettag = "streettag"
        static let phoneTag = "phone"
        static let enabled = "enabled"
        static let picker = "picker"
        static let categories = "categories"
        static let apttag = "apttag"
        static let textView = "textview"
        static let button = "button"
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
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.blackColor()
        
        self.navigationItem.title = "Profile"
        
        var appdelegate : AppDelegate
        
        appdelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        if appdelegate.initprofile == 0{
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Bordered, target: self, action: "cancel:")
        }else
        {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu.png"), style: .Bordered, target: self, action: "togglemenu:")
        }
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.blackColor()
        self.navigationController?.navigationBar.tintColor = UIColor(red: 250.0/255.0, green: 199.0/255.0, blue: 26.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 250.0/255.0, green: 199.0/255.0, blue: 26.0/255.0, alpha: 1.0)

        UINavigationBar.appearance().barTintColor = UIColor(red: 250.0/255.0, green: 199.0/255.0, blue: 26.0/255.0, alpha: 1.0)
    
      
        
    }
    
    /// MARK: Actions
    
    func done(_: UIBarButtonItem!) {
        
        
        
        var firstname: String = ""
        var lastname: String = ""
        var buildingtext: String = ""
        var emailtext: String = ""
        
        var streettext: String = ""
        var phonetext: String = ""
        var pickertext: String = ""
        
        var apttext : String = ""
        
        
        var formValue: NSDictionary = self.form.formValues() as NSDictionary
        
        
        firstname = formValue.objectForKey(Static.nameTag) as String
        
        lastname = formValue.objectForKey(Static.lastNameTag) as String
        
        buildingtext = formValue.objectForKey(Static.buildingtag) as String
        
        
        if formValue.objectForKey(Static.emailTag) as String != ""{
            
            emailtext = formValue.objectForKey(Static.emailTag) as String
        }else
        {
            var alertview:UIAlertView = UIAlertView(title: "Ooop", message: "Please fill your email address.", delegate: nil, cancelButtonTitle: "OK")
            alertview.show()
            return
        }
        
        
        streettext = formValue.objectForKey(Static.streettag) as String
        
        
        apttext = formValue.objectForKey(Static.apttag) as String
        
        
      
        
        
        phonetext = formValue.objectForKey(Static.phoneTag) as String
        
        pickertext = formValue.objectForKey(Static.picker) as String
        
        if streettext == "" || phonetext == "" || pickertext == "" || buildingtext == "" || lastname == "" || firstname == "" {
            
            var alertview:UIAlertView = UIAlertView(title: "Ooop", message: "Please fill your info (Apt is optional)", delegate: nil, cancelButtonTitle: "OK")
            alertview.show()
            return
        }
        
        
        
        
        var testify: Bool = formValue.objectForKey(Static.enabled) as Bool
        
        
        
        if let mUser = PFUser.currentUser() {
        
            
            mUser.setObject(firstname, forKey: "FirstName")
            mUser.setObject(lastname, forKey: "LastName")
            mUser.setObject(phonetext, forKey: "Phone")
            mUser.setObject(pickertext, forKey: "Borough")
            mUser.setObject(buildingtext, forKey: "Building")
            mUser.setObject(apttext, forKey: "Apt")
            mUser.setObject(testify, forKey: "testify")
            mUser.setObject(streettext, forKey: "StreetName")
            mUser.setObject(emailtext, forKey: "useremail")
            
            
            
            SVProgressHUD.showInfoWithStatus("Please wait", maskType: SVProgressHUDMaskType.Black)
            
            mUser.saveInBackgroundWithBlock{ (succeeded: Bool!, error: NSError!) -> Void in
                
                SVProgressHUD.dismiss()
                
                if !(error != nil) {
                    
                    var destViewController : UIViewController
                    
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
                    
                    destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("mycomplaints") as UIViewController
                    
                    
                    var appdelegate : AppDelegate
                    
                    appdelegate = UIApplication.sharedApplication().delegate as AppDelegate
                    appdelegate.window?.rootViewController = UINavigationController(rootViewController: destViewController);
                    
                } else {
                    
                    var alertview:UIAlertView = UIAlertView(title: "Ooop", message: error.description, delegate: nil, cancelButtonTitle: "OK")
                    alertview.show()
                    
                }
            }
            
            
            
        }else
        {
        
        
        var mUser : PFUser = PFUser()
        mUser.setObject(firstname, forKey: "FirstName")
        mUser.setObject(lastname, forKey: "LastName")
        mUser.setObject(phonetext, forKey: "Phone")
        mUser.setObject(pickertext, forKey: "Borough")
        mUser.setObject(buildingtext, forKey: "Building")
        mUser.setObject(apttext, forKey: "Apt")
        mUser.setObject(testify, forKey: "testify")
        mUser.setObject(streettext, forKey: "StreetName")
        mUser.setObject(emailtext, forKey: "useremail")
            var name111 : String =  self.createRandomName()
            
        mUser.username = name111
            
        mUser.password = "password123"
        
        SVProgressHUD.showInfoWithStatus("Please wait", maskType: SVProgressHUDMaskType.Black)
       
        mUser.signUpInBackgroundWithBlock {
            (succeeded: Bool!, error: NSError!) -> Void in
            
            SVProgressHUD.dismiss()
            
            if !(error != nil) {
                
                var destViewController : UIViewController
                
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
                
                destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("mycomplaints") as UIViewController
                
                
                var appdelegate : AppDelegate
                
                appdelegate = UIApplication.sharedApplication().delegate as AppDelegate
                appdelegate.window?.rootViewController = UINavigationController(rootViewController: destViewController);
                
            } else {
                
                var alertview:UIAlertView = UIAlertView(title: "Ooop", message: error.description, delegate: nil, cancelButtonTitle: "OK")
                alertview.show()
                
            }
        }
        }
        
        
    }
    
    func createRandomName() -> String
    {
        var uuid:String = NSUUID().UUIDString
        
        return uuid
    }
    
    func cancel(_: UIBarButtonItem!) {
        self.navigationController?.popViewControllerAnimated(true)

        
        
        
    }
    func togglemenu(_: UIBarButtonItem!) {
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var toViewController : UITableViewController
        
        toViewController = mainStoryboard.instantiateViewControllerWithIdentifier("sidebar") as UITableViewController
        
        self.modalPresentationStyle = UIModalPresentationStyle.Custom
        toViewController.transitioningDelegate = self.transitionOperator
        self .presentViewController(toViewController, animated: true) { () -> Void in
            
            
        }
        
        
        
    }
    
    
    /// MARK: Private interface
    
    private func loadForm() {
        
        let form = FormDescriptor()
        
        form.title = "Profile"
        
        let section1 = FormSectionDescriptor()
        
        var row : FormRowDescriptor! = FormRowDescriptor (tag: Static.button, rowType: .Button, title: "Required to submite a complaint but you only have to do it once")
        
     
        
        section1.addRow(row)
        
        
        row = FormRowDescriptor (tag: Static.nameTag, rowType: .Name, title: "First Name")
        
        if let mUser = PFUser.currentUser() {
            row.value = mUser.objectForKey("FirstName") as NSString
        }
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "Cosmo", "textField.textAlignment" : NSTextAlignment.Left.rawValue]
        section1.addRow(row)
        
        row = FormRowDescriptor(tag: Static.lastNameTag, rowType: .Name, title: "Last Name")
        if let mUser = PFUser.currentUser() {
            row.value = mUser.objectForKey("LastName") as NSString
        }
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "Kramer", "textField.textAlignment" : NSTextAlignment.Left.rawValue]
        section1.addRow(row)
        
        
        row = FormRowDescriptor(tag: Static.emailTag, rowType: .Email, title: "Email")
        if let mUser = PFUser.currentUser() {
            row.value = mUser.objectForKey("useremail") as NSString
        }
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "cosmo.kramer@email.com", "textField.textAlignment" : NSTextAlignment.Left.rawValue]
        section1.addRow(row)
        
 
        
        
        row = FormRowDescriptor(tag: Static.phoneTag, rowType: .Phone, title: "Phone #")
        if let mUser = PFUser.currentUser() {
            row.value = mUser.objectForKey("Phone") as NSString
        }
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "(212)555-3455", "textField.textAlignment" : NSTextAlignment.Left.rawValue]
        section1.addRow(row)
        
        row = FormRowDescriptor(tag: Static.picker, rowType: .Picker, title: "Borough")
        if let mUser = PFUser.currentUser() {
            row.value = mUser.objectForKey("Borough") as NSString
        }
        row.configuration[FormRowDescriptor.Configuration.Options] = ["Bronx", "Brooklyn", "Manhattan", "Queens", "Staten Island"]
        row.configuration[FormRowDescriptor.Configuration.TitleFormatterClosure] = { value in
            switch( value ) {
            case "Bronx":
                return "Bronx"
            case "Brooklyn":
                return "Brooklyn"
            case "Manhattan":
                return "Manhattan"
            case "Queens":
                return "Queens"
            case "Staten Island":
                return "Staten Island"
            default:
                return ""
            }
            } as TitleFormatterClosure
        
        section1.addRow(row)
        
        
        
        row = FormRowDescriptor(tag: Static.buildingtag, rowType: .Text, title: "Building #")
        if let mUser = PFUser.currentUser() {
            row.value = mUser.objectForKey("Building") as NSString
        }
        
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "129", "textField.textAlignment" : NSTextAlignment.Left.rawValue]
        section1.addRow(row)
        
        
        
        row = FormRowDescriptor(tag: Static.streettag, rowType: .Name, title: "Street Name")
        if let mUser = PFUser.currentUser() {
            row.value = mUser.objectForKey("StreetName") as NSString
        }
        
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "W. 81st Street", "textField.textAlignment" : NSTextAlignment.Left.rawValue]
        section1.addRow(row)
        
        row = FormRowDescriptor(tag: Static.apttag, rowType: .Name, title: "Apt #")
        if let mUser = PFUser.currentUser() {
            row.value = mUser.objectForKey("Apt") as NSString
        }
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "5A", "textField.textAlignment" : NSTextAlignment.Left.rawValue]
        section1.addRow(row)
        
        
        
        
        row = FormRowDescriptor(tag: Static.enabled, rowType: .BooleanSwitch, title: "I'm willing to testify at a hearing?( About x% of complaints end up going to trial.) You can testify by phone.")
        if let mUser = PFUser.currentUser() {
            row.value = mUser.objectForKey("testify") as Bool
        }else
        {
            row.value = true
        }
        section1.addRow(row)
        
        
        row  = FormRowDescriptor (tag: Static.button, rowType: .Button, title: "Privacy Policy: This information is ONLY used to submit 311 complaints for you. We do not use this info for ANYTHING else.")
        
        
        
        section1.addRow(row)
        
        
        
        form.sections = [section1]
        
        self.form = form
    }
    
    /// MARK: FormViewControllerDelegate
    
    func formViewController(controller: FormViewController, didSelectRowDescriptor rowDescriptor: FormRowDescriptor) {
        
        
    }
    

   
    
    
    
}
