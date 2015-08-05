//
//  DetailReportViewController.swift
//  swiftLogin
//
//  Created by Fang on 1/20/15.
//  Copyright (c) 2015 iOS-Blog. All rights reserved.
//

import UIKit
import MapKit

import Social

class DetailReportViewController: UIViewController , MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var Map: MKMapView!
    
    
    @IBOutlet weak var txttitle: UILabel!
    
    @IBOutlet weak var txtdescription: UILabel!
    
    @IBOutlet weak var lbldate: UILabel!
    
    @IBOutlet weak var lblrequest: UILabel!
    
    @IBOutlet weak var lblmedallion: UILabel!
    
    @IBOutlet weak var lblcategory: UILabel!
    
    
    @IBOutlet weak var imgstatus: UIView!
    
    
    @IBOutlet weak var mainview: UIView!
    
    @IBOutlet weak var bottomview: UIView!
    @IBOutlet var scrollview: UIScrollView!
    
    
    @IBOutlet weak var linelast: UILabel!
    
    @IBOutlet weak var lbl2013: UILabel!
    
    @IBOutlet weak var lblcountofcomplaints: UILabel!
    
    @IBOutlet weak var imgPercent: UIImageView!
    
    
    @IBOutlet weak var imgblueright: UIImageView!
    
    @IBOutlet weak var lblshare: UILabel!
    
    
    @IBOutlet weak var lblsharebackground: UILabel!
    
    @IBOutlet weak var btnfb: UIButton!
    
    
    @IBOutlet weak var btntwitter: UIButton!
    
    var anotation = MKPointAnnotation()
    
    
    
    var coordinatemap :CLLocation!
    var dataofReport:PFObject!
    var reportType:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 250.0/255.0, green: 199.0/255.0, blue: 26.0/255.0, alpha: 1.0)
       
        
       
        
        // Do any additional setup after loading the view.
    }

  
    override func  viewDidAppear(animated: Bool) {
        
        let submitdate:NSDate = dataofReport.objectForKey("timeofreport") as NSDate;
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy, h:mm" // superset of OP's format
        let str1:String = dateFormatter.stringFromDate(submitdate)
        
        
        lbldate.text = str1
        txtdescription.text = dataofReport.objectForKey("reportDescription1") as? String
        txtdescription.numberOfLines = 0
        txtdescription.lineBreakMode = NSLineBreakMode.ByWordWrapping
        txtdescription.sizeToFit()
        
        
        txttitle.numberOfLines = 0
        txttitle.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        
        var tmpframe: CGRect = bottomview.frame
        tmpframe.origin.y = txtdescription.frame.origin.y + txtdescription.frame.height+8
        
        bottomview.frame = tmpframe
        
        
        
        lblmedallion.text = dataofReport.objectForKey("medallionNo") as? String
        lblcategory.text = dataofReport.objectForKey("typeofcomplaint") as? String
        imgstatus.layer.cornerRadius = 7
        
        
        
        
        let status = dataofReport.objectForKey("status") as Int
        
        
        switch(status)
        {
        case 0:
            
            imgstatus.backgroundColor = UIColor.yellowColor()
            txttitle.text = "Submitted to Reported \nYour complaint has been submitted to Reported. It may take up to 24 hours for your complaint to get submitted to 311."
            break
        case 1:
            
            imgstatus.backgroundColor = UIColor.greenColor()
            txttitle.text = "Submitted to 311 \nYour complaint has been submitted to 311. Expect a phone call from a TLC attorney within a week to ask about the incident, identify the driver and verify the vehicle’s location."
            break
            
        case 2:
            
            imgstatus.backgroundColor = UIColor.blueColor()
            txttitle.text = "Summons issued \nA summons has been issued to the driver. If the driver pays the fine, this complaint will be closed. If they respond “not guilty,” then a hearing may be scheduled."
            break
            
        case 3:
            
            imgstatus.backgroundColor = UIColor.redColor()
            txttitle.text = "Hearing Scheduled \nA hearing has been scheduled for this complaint"
            break
        case 4:
            
            imgstatus.backgroundColor = UIColor.blackColor()
            txttitle.text = "Closed"
            break
            
        default:
            
            
            imgstatus.backgroundColor = UIColor.greenColor()
            txttitle.text = "SUBMITTED TO Reported"
            break
        }
        
        txttitle.sizeToFit()
        
        
        
        lblrequest.text = dataofReport.objectForKey("reqnumber") as? String
        
        var stLatitude = dataofReport.objectForKey("latitude") as NSString
        
        
        var stLongitude = dataofReport.objectForKey("longitude") as NSString
        
        var doubleLongitude : Double = stLongitude.doubleValue
        var doubleLatitude : Double = stLatitude.doubleValue
        
        
        let center = CLLocationCoordinate2D(latitude: doubleLatitude, longitude: doubleLongitude)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        Map.setRegion(region, animated: true)
        
        
        
        
        
        anotation.coordinate = center
        anotation.title = "Taxi location"
        anotation.subtitle = "This is the location !!!"
        
        Map.addAnnotation(anotation)
        
        
        reportType = dataofReport.objectForKey("selectedReport") as Int
        
        if reportType == 1 {
            let path = NSBundle.mainBundle().pathForResource("categories", ofType: "json")
            
            
            let jsonData = NSData(contentsOfFile: path!, options: .DataReadingMappedIfSafe, error: nil)
            var jsonResult: NSMutableArray = NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSMutableArray
            
            var tempdic:NSMutableDictionary
            
            for tempdic  in jsonResult {
                
                
                var typestring :String = tempdic.objectForKey("category") as String
                
                var percent : String = tempdic.objectForKey("percent") as String
                
                if typestring == lblcategory.text{
                    lblcountofcomplaints.text = percent
                }
            }

        }else
        {
            linelast.hidden = true
            imgPercent.hidden = true
            lbl2013.hidden = true
            lblcountofcomplaints.hidden = true
            imgblueright.hidden = true
            
            var tmpframe: CGRect = lblshare.frame
            tmpframe.origin.y -= 65
            lblshare.frame = tmpframe
            
            tmpframe = lblsharebackground.frame
            
            tmpframe.origin.y -= 65
            lblsharebackground.frame = tmpframe
            
            
            tmpframe = btnfb.frame
            
            tmpframe.origin.y -= 65
            btnfb.frame = tmpframe
            
            tmpframe = btntwitter.frame
            
            tmpframe.origin.y -= 65
            btntwitter.frame = tmpframe
            
            
            tmpframe = bottomview.frame
            
            tmpframe.size.height -= 65
            bottomview.frame = tmpframe
            
        }
        
        
        
        tmpframe = mainview.frame
        tmpframe.origin.y = txttitle.frame.origin.y + txttitle.frame.height+8
        
        mainview.frame = tmpframe
        
        self.scrollview.contentSize = CGSizeMake(320,mainview.frame.origin.y+bottomview.frame.origin.y+bottomview.frame.size.height);
        

        
        
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView!
    {
        
        
        
        let reuseId = "test"
        
        
        var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        
        if anView == nil {
            
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            
            
            
            anView.canShowCallout = true
            anView.draggable = true
            
        }
            
        else {
            //we are re-using a view, update its annotation reference...
            anView.canShowCallout = true
            anView.draggable = true
            anView.annotation = annotation
            
        }
        
        
        return anView
        
    }
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func clickback(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
        
        
    }
    
    @IBAction func clickfbshare(sender: AnyObject) {
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
            var facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookSheet.setInitialText("Please join TaxiReport App")
            self.presentViewController(facebookSheet, animated: true, completion: nil)
        } else {
            var alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func clicktwshare(sender: AnyObject) {
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter){
            var twitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterSheet.setInitialText("Please join TaxiReport App")
            self.presentViewController(twitterSheet, animated: true, completion: nil)
        } else {
            var alert = UIAlertController(title: "Accounts", message: "Please login to a Twitter account to share.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func clickcategory(sender: AnyObject) {
        
        if reportType == 0{
            return
        }
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : ComplaintTypeViewController
        
        
        
        destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("complainttype") as ComplaintTypeViewController
        destViewController.categorytype = lblcategory.text
        
        
        self.navigationController?.pushViewController(destViewController, animated: true)
        
        
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
