//
//  DriverLicenseViewController.swift
//  swiftLogin
//
//  Created by Fang on 1/20/15.
//  Copyright (c) 2015 iOS-Blog. All rights reserved.
//

import UIKit

class DriverLicenseViewController: UIViewController {

    
    @IBOutlet var medallionText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 250.0/255.0, green: 199.0/255.0, blue: 26.0/255.0, alpha: 1.0)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func clickback(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
        
    
    }
    @IBAction func clicknext(sender:AnyObject)
    {
        if (self.medallionText.text.isEmpty)
        {
            var alertview:UIAlertView = UIAlertView(title: "Ooop", message: "Please input medallion number, cab license or driver's license.", delegate: nil, cancelButtonTitle: "OK")
            alertview.show()
            
            return
        }
        self.view.endEditing(true)
        var appdelegate = UIApplication.sharedApplication().delegate as AppDelegate
        appdelegate.medallionNo = self.medallionText.text
        
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController

        destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("geolocation") as UIViewController
        
        self.navigationController?.pushViewController(destViewController, animated: true)
        
    }
    
    @IBAction func clickimage(sender: AnyObject) {
        
        
        
    }
    

}
