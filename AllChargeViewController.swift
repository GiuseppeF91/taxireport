//
//  AllChargeViewController.swift
//  taxireport
//
//  Created by Fang on 2/20/15.
//  Copyright (c) 2015 iOS-Blog. All rights reserved.
//

import UIKit

class AllChargeViewController: UIViewController {

    
    
    var transitionOperator = TransitionOperator()
    @IBOutlet var container:UITableView!
    
    var jsonResult:NSMutableArray = []
    var submitionArray: NSArray! = NSArray ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 250.0/255.0, green: 199.0/255.0, blue: 26.0/255.0, alpha: 1.0)
        
        self.navigationController?.navigationBar.hidden = true
        
        self.navigationController?.navigationBar.hidden = true
        self.container.registerClass(ChargeFineCellViewController.self, forCellReuseIdentifier: "mycell")
        
        let path = NSBundle.mainBundle().pathForResource("charges", ofType: "json")
        
        
        
        let jsonData = NSData(contentsOfFile: path!, options: .DataReadingMappedIfSafe, error: nil)
        jsonResult  = NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSMutableArray
        
        
        
        
        
        for var index = 0; index < jsonResult.count-1; ++index {
            for var index1 = index+1; index1 < jsonResult.count; ++index1 {
                
                
                var item1 : NSMutableDictionary = jsonResult.objectAtIndex(index) as NSMutableDictionary
                var violations : NSMutableDictionary = item1.objectForKey("violations") as NSMutableDictionary
                var countofcomplaints : String = violations.objectForKey("total_violations") as String
                var nCount = countofcomplaints.toInt()
                
                ///
                
                var item2 : NSMutableDictionary = jsonResult.objectAtIndex(index1) as NSMutableDictionary
                var violations2 : NSMutableDictionary = item2.objectForKey("violations") as NSMutableDictionary
                var countofcomplaints2 : String = violations2.objectForKey("total_violations") as String
                var nCount2 = countofcomplaints2.toInt()
                
                if nCount < nCount2{
                    jsonResult.exchangeObjectAtIndex(index, withObjectAtIndex: index1)
                }
                
            }
            
        }
        
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func clickback(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
        
        
    }
    
    /* table view delegate
    
    */
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        
        return self.jsonResult.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:ChargeFineCellViewController = tableView.dequeueReusableCellWithIdentifier("mycell") as ChargeFineCellViewController
        
        
        var object: NSMutableDictionary = self.jsonResult.objectAtIndex(indexPath.row)
            as NSMutableDictionary
        
        
        cell.lbltitle.text = object.objectForKey("tlc_category") as? String
        
        var violations : NSMutableDictionary = object.objectForKey("violations") as NSMutableDictionary
        
        var countofcomplaints : String = violations.objectForKey("total_violations") as String
        
        
        countofcomplaints  = String(format: "%@ Complaints", countofcomplaints)
        
        
        cell.lblcountofcomplaints.text = countofcomplaints
        
        
        var percentcomplaints : String = violations.objectForKey("complaints_percentage_2013") as String
        
        
        percentcomplaints  = String(format: "%@%% of Complaints", percentcomplaints)
        
        
        cell.lblpercents.text = percentcomplaints
        
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        var object: NSMutableDictionary = self.jsonResult.objectAtIndex(indexPath.row)
            as NSMutableDictionary
        
        
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : FraudTheftViewController
        
        
        
        
        destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("fraud") as FraudTheftViewController
        destViewController.dataCharge = object
        
        
        self.navigationController?.pushViewController(destViewController, animated: true)
        
        
        
    }
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 67
    }
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }
    
    
    
    
    
    
}
