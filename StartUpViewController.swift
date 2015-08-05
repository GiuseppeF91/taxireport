//
//  StartUpViewController.swift
//  swiftLogin
//
//  Created by Fang on 1/20/15.
//  Copyright (c) 2015 iOS-Blog. All rights reserved.
//

import UIKit

class StartUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden = true
        
        self.view.backgroundColor = UIColor(red: 250.0/255.0, green: 199.0/255.0, blue: 26.0/255.0, alpha: 1.0)
        

        if let mUser = PFUser.currentUser() {
            
        var destViewController : UIViewController
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        
        destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("mycomplaints") as UIViewController
        
        
        var appdelegate : AppDelegate
        
        appdelegate = UIApplication.sharedApplication().delegate as AppDelegate
        appdelegate.window?.rootViewController = UINavigationController(rootViewController: destViewController);
        }
        
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
    @IBAction func clicklater(sender: AnyObject) {
        var destViewController : UIViewController
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        
        destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("mycomplaints") as UIViewController
        
        
        var appdelegate : AppDelegate
        
        appdelegate = UIApplication.sharedApplication().delegate as AppDelegate
        appdelegate.window?.rootViewController = UINavigationController(rootViewController: destViewController);
        
    }

    
    

}
