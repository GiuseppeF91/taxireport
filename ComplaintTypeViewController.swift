//
//  ComplaintTypeViewController.swift
//  taxireport
//
//  Created by Fang on 1/27/15.
//  Copyright (c) 2015 iOS-Blog. All rights reserved.
//

import UIKit

class ComplaintTypeViewController: UIViewController {

    
    @IBOutlet var scrollview: UIScrollView!
    @IBOutlet var lblcount: UILabel!
    
    @IBOutlet var lblpercent: UILabel!
    
    @IBOutlet var btnTitle: UIButton!
    
    @IBOutlet var content: UITableView!
    
    var categorytype: String!
    
    
    var chargeResult:NSMutableArray = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.content.registerClass(ChargeFineCellViewController.self, forCellReuseIdentifier: "mycell")
        
        
        self.view.backgroundColor = UIColor(red: 250.0/255.0, green: 199.0/255.0, blue: 26.0/255.0, alpha: 1.0)
        
        let path = NSBundle.mainBundle().pathForResource("categories", ofType: "json")
        
        
        let jsonData = NSData(contentsOfFile: path!, options: .DataReadingMappedIfSafe, error: nil)
        var jsonResult: NSMutableArray = NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSMutableArray
        
        var tempdic:NSMutableDictionary
        
        for tempdic  in jsonResult {
            
            
            var typestring :String = tempdic.objectForKey("category") as String
         
            if typestring == categorytype{
                
                
                switch (typestring)
                {
                case "Used a cell phone while driving":
//                    btntype.setImage(UIImage(named: "usecellphone.png"), forState: UIControlState.Normal)
                    
                    btnTitle.setTitle("Used a cell phone while driving", forState: .Normal)
                 
                    
                    break
                case "Overcharges, demands tips, or does not use E-Z Pass":
//                    btntype.setImage(UIImage(named: "overcharges.png"), forState: UIControlState.Normal)
                    btnTitle.setTitle("Overcharges, demands tips, or does not use E-Z Pass", forState: .Normal)
                    
                    break
                case "Refuses to pick up a passenger":
//                    btntype.setImage(UIImage(named: "pickuppassenger.png"), forState: UIControlState.Normal)
                    btnTitle.setTitle("Refuses to pick up a passenger", forState: .Normal)
                    break
                case "Refused a credit card":
//                    btntype.setImage(UIImage(named: "refusecredit.png"), forState: UIControlState.Normal)
                    btnTitle.setTitle("Refused a credit card", forState: .Normal)
                    
                    break
                case "Refuses passenger requests":
//                    btntype.setImage(UIImage(named: "refuserequest.png"), forState: UIControlState.Normal)
                    btnTitle.setTitle("Refuses passenger requests", forState: .Normal)
                    
                    break
                case "Driver is rude":
//                    btntype.setImage(UIImage(named: "driverrude.png"), forState: UIControlState.Normal)
                    btnTitle.setTitle("Driver is rude", forState: .Normal)
                    
                    break
                case "Reckless or unsafe if you were the passenger":
//                    btntype.setImage(UIImage(named: "recklessunsafe.png"), forState: UIControlState.Normal)
                    btnTitle.setTitle("Reckless or unsafe if you were the passenger", forState: .Normal)
                    
                    break
                case "Reckless or unsafe if you were NOT the passenger":
//                    btntype.setImage(UIImage(named: "recklessunsafepass.png"), forState: UIControlState.Normal)
                    btnTitle.setTitle("Reckless or unsafe if you were NOT the passenger", forState: .Normal)
                    
                    break
                case "Takes a long route or refuses route requests":
//                    btntype.setImage(UIImage(named: "routrequest.png"), forState: UIControlState.Normal)
                    btnTitle.setTitle("Takes a long route or refuses route requests", forState: .Normal)
                    break
                case "Fails to display a license":
//                    btntype.setImage(UIImage(named: "faillicense.png"), forState: UIControlState.Normal)
                    btnTitle.setTitle("Fails to display a license", forState: .Normal)
                    break
                case "Taxi is dirty":
//                    btntype.setImage(UIImage(named: "taxidirty.png"), forState: UIControlState.Normal)
                    btnTitle.setTitle("Taxi is dirty", forState: .Normal)
                    break
                case "Taxi has broken or missing equipment":
//                    btntype.setImage(UIImage(named: "taxibroken.png"), forState: UIControlState.Normal)
                    btnTitle.setTitle("Taxi has broken or missing equipment", forState: .Normal)
                    break
                case "Other problems":
//                    btntype.setImage(UIImage(named: "otherproblems.png"), forState: UIControlState.Normal)
                    btnTitle.setTitle("Other problems", forState: .Normal)
                    break
                    
                default:
                    break
                }

                
                
                
                
                var percent : String = tempdic.objectForKey("percent") as String
                lblpercent.text = percent + " Complaints"
                
                var count : String = tempdic.objectForKey("count") as String
                lblcount.text = count + "% of Complaints"
                
                var arraycharge : NSMutableArray = tempdic.objectForKey("charge_codes") as NSMutableArray
                
                var totalitem : String = ""
                
                
                
                
                let path = NSBundle.mainBundle().pathForResource("charges", ofType: "json")
                
                
                
                let jsonData = NSData(contentsOfFile: path!, options: .DataReadingMappedIfSafe, error: nil)
                var jsonResult1  = NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSMutableArray
                
                
                

                
                
                for var index = 0; index < arraycharge.count; ++index {
                    
                    
                    var item1 : String = arraycharge.objectAtIndex(index) as String
                    
                    
                    
                    
                    for var index1 = 0; index1 < jsonResult1.count-1; ++index1 {
                        
                        var object: NSMutableDictionary = jsonResult1.objectAtIndex(index1)
                            as NSMutableDictionary
                        
                        
                        var chargecode = object.objectForKey("charge_code") as? String
                        
                        
                        if chargecode == item1 {
                            chargeResult.addObject(object)
                        }
                        
                    }
                    
                    
                }
                
             
                
                content.reloadData()
//                txtchargecodes.text = totalitem
                
                
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    /* table view delegate
    
    */
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return self.chargeResult.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:ChargeFineCellViewController = tableView.dequeueReusableCellWithIdentifier("mycell") as ChargeFineCellViewController
        
        
        var object: NSMutableDictionary = self.chargeResult.objectAtIndex(indexPath.row)
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
        
        
        var object: NSMutableDictionary = self.chargeResult.objectAtIndex(indexPath.row)
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
