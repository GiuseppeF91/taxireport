//
//  ReportTaxiMainController.swift
//  swiftLogin
//
//  Created by Jun Lee on 1/19/15.
//  Copyright (c) 2015  Jun Lee. All rights reserved.
//

import UIKit
import MapKit

class ReportTaxiMainController: UIViewController,UITableViewDataSource,  UITableViewDelegate, DetailCellDelegate{

   
    
    @IBOutlet var menubutton: UIButton!
    
    @IBOutlet var menu: UIView!
    
    @IBOutlet var container:UITableView!
    
    @IBOutlet var carimage:UIImageView!
    @IBOutlet var lblnoreport:UILabel!
    
    @IBOutlet var lblnoreportdesc:UILabel!
    
    var trianglePlacement:CGFloat = 0.0
    var shouldDisplayDropShape:Bool = false
    
    
    var openMenuShape:CAShapeLayer = CAShapeLayer()
    var closedMenuShape:CAShapeLayer = CAShapeLayer()
    

  
    var submitionArray: NSArray! = NSArray ()
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblnoreport.hidden = true
        self.lblnoreportdesc.hidden = true
        self.carimage.hidden = true
        
        self.container.registerClass(ReportMainTableCell.self, forCellReuseIdentifier: "mycell")
        
        var query :PFQuery = PFQuery(className: "submission")
        query.orderByDescending("createdAt")
        SVProgressHUD .showWithStatus("Loading...", maskType: SVProgressHUDMaskType.Black)
        query.findObjectsInBackgroundWithBlock({(NSArray objects, NSError error) in
            
            SVProgressHUD.dismiss()
            if (error != nil) {
                NSLog("error " + error.localizedDescription)
            }
            else {
                NSLog("objects %@", objects as! NSArray)
                self.submitionArray = objects
                self.container.reloadData()
                
                if (self.submitionArray.count > 0 )
                {
                    self.lblnoreport.hidden = true
                    self.lblnoreportdesc.hidden = true
                    self.carimage.hidden = true
                    
                }else
                {
                    self.lblnoreport.hidden = false
                    self.lblnoreportdesc.hidden = false
                    self.carimage.hidden = false
                }
            }
        })
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(animated: Bool) {
        self.drawOpenLayer()
        self.drawClosedLayer()
        
        var appdelegate : AppDelegate
        
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
      
        
        
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toggleSideMenu(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    
    
    
    func drawOpenLayer()
    {
        
        
        // Constants to ease drawing the border and the stroke.
        var height:CGFloat = self.menubutton.frame.size.height
        var width:CGFloat = self.menubutton.frame.size.width
        var  triangleDirection:CGFloat = 1 // 1 for down, -1 for up.
        var triangleSize:CGFloat =  8
        var trianglePosition:CGFloat = trianglePlacement*width
        
        // The path for the triangle (showing that the menu is open).
        var triangleShape:UIBezierPath = UIBezierPath()
        
        triangleShape.moveToPoint(CGPointMake(trianglePosition, height))
        triangleShape.addLineToPoint(CGPointMake(trianglePosition+triangleSize, height+triangleDirection*triangleSize))
        
        triangleShape.addLineToPoint(CGPointMake(trianglePosition+2*triangleSize, height))
        triangleShape.addLineToPoint(CGPointMake(trianglePosition, height))
        
        
        openMenuShape.path = triangleShape.CGPath
        
        openMenuShape.fillColor = self.menubutton.backgroundColor?.CGColor
        
        
        var borderPath:UIBezierPath = UIBezierPath()
        
        borderPath.moveToPoint(CGPointMake(0, height))
        
        borderPath.addLineToPoint(CGPointMake(trianglePosition, height))
        
        borderPath.addLineToPoint(CGPointMake(trianglePosition+triangleSize, height+triangleDirection*triangleSize))
        
        borderPath.addLineToPoint(CGPointMake(trianglePosition+2*triangleSize, height))
        
        borderPath.addLineToPoint(CGPointMake(width, height))
        
        
        openMenuShape.path = borderPath.CGPath
        
        openMenuShape.strokeColor = UIColor.whiteColor().CGColor
        
        
        openMenuShape.bounds = CGRectMake(0.0, 0.0, height+triangleSize, width)
        
        openMenuShape.anchorPoint = CGPointMake(0.0, 0.0)
        openMenuShape.position  = CGPointMake(0.0 , 0.0)
        
    }
    
    func drawClosedLayer()
    {
        
        
        
        // Constants to ease drawing the border and the stroke.
        var height:CGFloat = self.menubutton.frame.size.height
        var width:CGFloat = self.menubutton.frame.size.width
        
        var borderPath:UIBezierPath = UIBezierPath()
        
        borderPath.moveToPoint(CGPointMake(0, height))
        
        borderPath.addLineToPoint(CGPointMake(width, height))
        
        
        closedMenuShape.path = borderPath.CGPath
        
        closedMenuShape.strokeColor = UIColor.whiteColor().CGColor
        
        closedMenuShape.bounds = CGRectMake(0.0, 0.0, height, width)
        
        closedMenuShape.anchorPoint = CGPointMake(0.0, 0.0)
        
        closedMenuShape.position = CGPointMake(0.0, 0.0)
        
    }

    
    func showMenu()
    {
        self.menu.hidden = false;
    
        closedMenuShape.removeFromSuperlayer()
        
        if (shouldDisplayDropShape)
        {
            self.view.layer.addSublayer(openMenuShape)
            
        }
    
        // Set new origin of menu
        var menuFrame:CGRect = self.menu.frame
        menuFrame.origin.y = self.menubutton.frame.origin.y+self.menubutton.frame.size.height-20
    
        // Set new alpha of Container View (to get fade effect)
        var  containerAlpha:CGFloat = 0.5
    
       
        UIView.animateWithDuration(0.4, delay: 0.0, options: .CurveEaseOut, animations: {
        
        self.menu.frame = menuFrame
        self.container.alpha =  containerAlpha
        
        }, completion: {
        finished in
        
        
        })
        
    
        UIView.commitAnimations()
        
    }
    
    func hideMenu()
    {
    // Set the border layer to hidden menu state
        openMenuShape.removeFromSuperlayer()
        self.view.layer.addSublayer(closedMenuShape)
        
    // Set new origin of menu
        var menuFrame:CGRect = self.menu.frame;
        menuFrame.origin.y = self.menubutton.frame.origin.y+self.menubutton.frame.size.height-menuFrame.size.height
    
        // Set new alpha of Container View (to get fade effect)
        var containerAlpha:CGFloat = 1.0
    
        
        UIView.animateWithDuration(0.3, delay: 0.05, options: .CurveEaseInOut, animations: {
            
            self.menu.frame = menuFrame
            self.container.alpha =  containerAlpha
            
            }, completion: {
                finished in
                self.menu.hidden = true
                
        })
        
        
        
        UIView.commitAnimations()
    
    }
    
    @IBAction func tapDetected(sender: UITapGestureRecognizer) {
        
        var tapLocation:CGPoint = sender.locationInView(self.view)
        
        
        // If menu is open, and the tap is outside of the menu, close it.
        if (!CGRectContainsPoint(self.menu.frame, tapLocation) && !self.menu.hidden) {
            self.hideMenu()
            
        }

    }
    
    @IBAction func showDropdownmenu(sender: AnyObject) {
        self.showMenu()
        
    }
    
    @IBAction func clickcompliment(sender: AnyObject) {
        var appdelegate : AppDelegate
        
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appdelegate.selectedReport = 0
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        
        destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("driverlicense") as! UIViewController
        
        self.navigationController?.pushViewController(destViewController, animated: true)
        
    }
    
    @IBAction func clickcompliant(sender: AnyObject) {
        var appdelegate : AppDelegate
        
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appdelegate.selectedReport = 1
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        
        destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("driverlicense") as! UIViewController
        
        self.navigationController?.pushViewController(destViewController, animated: true)
        
        
    }
    
/* table view delegate

*/
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.submitionArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:ReportMainTableCell = tableView.dequeueReusableCellWithIdentifier("mycell") as! ReportMainTableCell
       
        
        var object: PFObject = self.submitionArray.objectAtIndex(indexPath.row)
         as! PFObject
        
        let submitdate:NSDate = object.objectForKey("timeofreport") as! NSDate;
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM dd,yyyy, h:mm" // superset of OP's format
        let str1:String = dateFormatter.stringFromDate(submitdate)
        
        
        cell.lbldate.text = str1
        cell.lbldescription.text = object.objectForKey("reportDescription") as? String
        
        cell.parentIndex = indexPath
                
        cell.delegate = self
        
        cell.imgstatus.layer.cornerRadius = 7
        let status = object.objectForKey("status") as! Int
        
        switch(status)
        {
        case 0:
            
            cell.imgstatus.backgroundColor = UIColor.greenColor()
            cell.lblstatus.text = "SUBMITTED TO 311"
            break
        case 1:
            
            cell.imgstatus.backgroundColor = UIColor.blackColor()
            cell.lblstatus.text = "RESOLVED"
            break
            
        case 2:
            
            cell.imgstatus.backgroundColor = UIColor.blueColor()
            cell.lblstatus.text = "NOT SUBMITTED"
            break
            
        case 3:
            
            cell.imgstatus.backgroundColor = UIColor.redColor()
            cell.lblstatus.text = "DELETED"
            break
        case 4:
            
            cell.imgstatus.backgroundColor = UIColor.yellowColor()
            cell.lblstatus.text = "DRAFT"
            break
            
        default:
        
            
            cell.imgstatus.backgroundColor = UIColor.greenColor()
            cell.lblstatus.text = "SUBMITTED TO 311"
            break
        }
        
        var stLatitude = object.objectForKey("latitude") as! NSString
        
        
        var stLongitude = object.objectForKey("longitude") as! NSString
        
        var doubleLongitude : Double = stLongitude.doubleValue
        var doubleLatitude : Double = stLatitude.doubleValue
        
        
        let center = CLLocationCoordinate2D(latitude: doubleLatitude, longitude: doubleLongitude)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        cell.maplocation.setRegion(region, animated: true)
        
        
        
        var anotation :MKPointAnnotation = MKPointAnnotation()
        
        anotation.coordinate = center
        anotation.title = "Taxi location"
        anotation.subtitle = "This is the location !!!"
        
        cell.maplocation.addAnnotation(anotation)
        
        
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 271
    }
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }
    
    func detailforCell(indexPath:NSIndexPath )
    {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : DetailReportViewController
        
        
        var object: PFObject = self.submitionArray.objectAtIndex(indexPath.row)
            as! PFObject
        
        
        destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("detailreport") as! DetailReportViewController
        destViewController.dataofReport = object
        
        
        self.navigationController?.pushViewController(destViewController, animated: true)

        
    }
    
    
    
}
