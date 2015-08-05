//
//  MyMenuTableViewController.swift
//  SwiftSideMenu
//
//  Created by Jun Lee on 29.09.14.
//  Copyright (c) 2014 Jun Lee. All rights reserved.
//

import UIKit

class MyMenuTableViewController: UITableViewController {
    var selectedMenuItem : Int = 0
    var arrayofTitle : NSArray = ["My Complaints", "Charges & Fines", "Look Up Driver", "My Profile", "FAQ", "Feedback", "Share"]
    var arrayofIcon : NSArray = ["mycompliant.png", "charge.png", "lookupdriver.png", "myprofile.png", "faq.png", "feedback.png", "share.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customize apperance of table view
        tableView.contentInset = UIEdgeInsetsMake(64.0, 0, 0, 0) //
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.blackColor()
        tableView.scrollsToTop = false
        
        // Preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        tableView.selectRowAtIndexPath(NSIndexPath(forRow: selectedMenuItem, inSection: 0), animated: false, scrollPosition: .Middle)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return arrayofTitle.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("CELL") as? UITableViewCell
        
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "CELL")
            cell!.backgroundColor = UIColor.blackColor()
            cell!.textLabel?.textColor = UIColor.whiteColor()
            let selectedBackgroundView = UIView(frame: CGRectMake(0, 0, cell!.frame.size.width, cell!.frame.size.height))
            selectedBackgroundView.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.2)
            cell!.selectedBackgroundView = selectedBackgroundView
            
            
        }
        
        cell!.textLabel?.text = arrayofTitle.objectAtIndex(indexPath.row)   as! String
        
        cell!.imageView?.image = UIImage(named: arrayofIcon.objectAtIndex(indexPath.row) as! String)
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        println("did select row: \(indexPath.row)")
        
        if (indexPath.row == selectedMenuItem) {
            sideMenuController()?.sideMenu?.hideSideMenu()
            return
        }
        selectedMenuItem = indexPath.row
        
        //Present new view controller
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        switch (indexPath.row) {
        case 0:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("mycomplaints") as! UIViewController
            break
        case 1:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("charges") as! UIViewController
            break
        case 2:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("driverlookup") as! UIViewController
            break
        case 3:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("myprofile") as! UIViewController
            break
        case 4:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("faq") as! UIViewController
            break
        case 5:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("feedback") as! UIViewController
            break
        case 6:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("share") as! UIViewController
            break
            
        default:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("mycomplaints") as! UIViewController
            break
        }
        sideMenuController()?.setContentViewController(destViewController)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
