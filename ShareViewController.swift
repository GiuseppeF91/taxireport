//
//  ShareViewController.swift
//  Reported
//
//  Created by Joshua Weitzman on 1/8/15.
//  Copyright (c) 2015 Joshua Weitzman. All rights reserved.
//

import UIKit
import MessageUI
import Foundation
import Social

class ShareViewController: UIViewController ,MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate{
    
    
    var transitionOperator = TransitionOperator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 250.0/255.0, green: 199.0/255.0, blue: 26.0/255.0, alpha: 1.0)
        
        self.navigationController?.navigationBar.hidden = true
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func toggleSideMenu(sender: AnyObject) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var toViewController : UITableViewController
        
        toViewController = mainStoryboard.instantiateViewControllerWithIdentifier("sidebar") as UITableViewController
        
        self.modalPresentationStyle = UIModalPresentationStyle.Custom
        toViewController.transitioningDelegate = self.transitionOperator
        self .presentViewController(toViewController, animated: true) { () -> Void in
            
            
        }
        
    }
    
    @IBAction func sendEmailButtonTapped(sender: AnyObject) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setSubject("Check out Reported")
        mailComposerVC.setMessageBody("Download this app, it is that amazing. https://itunes.apple.com/us/app/reported/id916072964?ls=1&mt=8", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "For some reason your device will not send an e-mail. Please check your e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    @IBAction func shareFacebook(sender: AnyObject) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
            var facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookSheet.setInitialText("I'm using the most amazing app, Reported. Be like me and download it today at https://itunes.apple.com/us/app/reported/id916072964?ls=1&mt=8")
            self.presentViewController(facebookSheet, animated: true, completion: nil)
        } else {
            var alert = UIAlertController(title: "You have a sharing problem", message: "Sharing is good so please login to the Facebook to share this app throughout the interwebs.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func shareTwitter(sender: AnyObject) {
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter){
            var twitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterSheet.setInitialText("I'm using the most amazing app, Reported. Be like me and download it today at https://itunes.apple.com/us/app/reported/id916072964?ls=1&mt=8")
            self.presentViewController(twitterSheet, animated: true, completion: nil)
        } else {
            var alert = UIAlertController(title: "You have a sharing problem", message: "Please login to a Twitter account to share this app throughout the interwebs.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func shareSMS(sender: AnyObject) {
        
        if (MFMessageComposeViewController.canSendText()) {
            
            var messageVC = MFMessageComposeViewController()
            messageVC.body = "Check out Reported, https://itunes.apple.com/us/app/reported/id916072964?ls=1&mt=8";
            
            messageVC.messageComposeDelegate = self;
            
            self.presentViewController(messageVC, animated: false, completion: nil)
        }
        
        
        
        
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult) {
        switch (result.value) {
        case MessageComposeResultCancelled.value:
            println("Message was cancelled")
            self.dismissViewControllerAnimated(true, completion: nil)
        case MessageComposeResultFailed.value:
            println("Message failed")
            self.dismissViewControllerAnimated(true, completion: nil)
        case MessageComposeResultSent.value:
            println("Message was sent")
            self.dismissViewControllerAnimated(true, completion: nil)
        default:
            break;
        }
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
