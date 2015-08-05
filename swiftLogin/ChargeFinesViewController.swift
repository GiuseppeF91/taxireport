//
//  ChargeFinesViewController.swift
//  swiftLogin
//
//  Created by Jun Lee on 1/20/15.
//  Copyright (c) 2015  Jun Lee. All rights reserved.
//

import UIKit

class ChargeFinesViewController: UIViewController {

    
    @IBOutlet var container:UITableView!
    
    
    var submitionArray: NSArray! = NSArray ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.container.registerClass(ChargeFineCellViewController.self, forCellReuseIdentifier: "mycell")
        
//        
//        var query :PFQuery = PFQuery(className: "submission")
//        query.orderByDescending("createdAt")
//        SVProgressHUD .showWithStatus("Loading...", maskType: SVProgressHUDMaskType.Black)
//        query.findObjectsInBackgroundWithBlock({(NSArray objects, NSError error) in
//            
//            SVProgressHUD.dismiss()
//            if (error != nil) {
//                NSLog("error " + error.localizedDescription)
//            }
//            else {
//                NSLog("objects %@", objects as! NSArray)
//                self.submitionArray = objects
//                self.container.reloadData()
//                
//                if (self.submitionArray.count > 0 )
//                {
//                    self.lblnoreport.hidden = true
//                    self.lblnoreportdesc.hidden = true
//                    self.carimage.hidden = true
//                    
//                }else
//                {
//                    self.lblnoreport.hidden = false
//                    self.lblnoreportdesc.hidden = false
//                    self.carimage.hidden = false
//                }
//            }
//        })
//        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func toggleSideMenu(sender: AnyObject) {
        toggleSideMenuView()
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
