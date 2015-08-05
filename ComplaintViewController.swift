//
//  ComplaintViewController.swift
//  swiftLogin
//
//  Created by Fang on 1/20/15.
//  Copyright (c) 2015 iOS-Blog. All rights reserved.
//

import UIKit

class ComplaintViewController: UIViewController {

    @IBOutlet var scrollview: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 250.0/255.0, green: 199.0/255.0, blue: 26.0/255.0, alpha: 1.0)
        
        self.scrollview.contentSize = CGSizeMake(320,814);

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
        
        var appdelegate : AppDelegate
        
        appdelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        
        let selectedButton :UIButton = sender as UIButton
        
        switch (selectedButton.tag)
        {
        case 0:
            appdelegate.typeofcomplaint = "Used a cell phone while driving"
            break
        case 1:
            appdelegate.typeofcomplaint = "Overcharges, demands tips, or does not use E-Z Pass"
            break
        case 2:
            appdelegate.typeofcomplaint = "Refuses to pick up a passenger"
            break
        case 3:
            appdelegate.typeofcomplaint = "Refused a credit card"
            break
        case 4:
            appdelegate.typeofcomplaint = "Refuses passenger requests"
            break
        case 5:
            appdelegate.typeofcomplaint = "Driver is rude"
            break
        case 6:
            appdelegate.typeofcomplaint = "Reckless or unsafe if you were the passenger"
            break
        case 7:
            appdelegate.typeofcomplaint = "Reckless or unsafe if you were NOT the passenger"
            break
        case 8:
            appdelegate.typeofcomplaint = "Takes a long route or refuses route requests"
            break
        case 9:
            appdelegate.typeofcomplaint = "Fails to display a license"
            break
        case 10:
            appdelegate.typeofcomplaint = "Taxi is dirty"
            break
        case 11:
            appdelegate.typeofcomplaint = "Taxi has broken or missing equipment"
            break
        case 12:
            appdelegate.typeofcomplaint = "Other problems"
            break
        
        default:
            break
        }
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        
        
        
        destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("submit") as UIViewController
        
        
        self.navigationController?.pushViewController(destViewController, animated: true)
        
    }
    
}
