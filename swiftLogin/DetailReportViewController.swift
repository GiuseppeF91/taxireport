//
//  DetailReportViewController.swift
//  swiftLogin
//
//  Created by Fang on 1/20/15.
//  Copyright (c) 2015 iOS-Blog. All rights reserved.
//

import UIKit
import MapKit
class DetailReportViewController: UIViewController , MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var Map: MKMapView!
    
    
    @IBOutlet weak var txttitle: UITextView!
    
    @IBOutlet weak var txtdescription: UITextView!
    
    @IBOutlet weak var lbldate: UILabel!
    
    @IBOutlet weak var lblrequest: UILabel!
    
    @IBOutlet weak var lblmedallion: UILabel!
    
    @IBOutlet weak var lblcategory: UILabel!
    
    @IBOutlet weak var lblcountofcomplaints: UILabel!
    
    
    @IBOutlet weak var imgstatus: UIView!
    
    
    @IBOutlet var scrollview: UIScrollView!
    
    var anotation = MKPointAnnotation()
    
    
    
    var coordinatemap :CLLocation!
    var dataofReport:PFObject!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.scrollview.contentSize = CGSizeMake(320,660);
        
        let submitdate:NSDate = dataofReport.objectForKey("timeofreport") as! NSDate;
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM dd,yyyy, h:mm" // superset of OP's format
        let str1:String = dateFormatter.stringFromDate(submitdate)
        
        
        lbldate.text = str1
        txtdescription.text = dataofReport.objectForKey("reportDescription") as? String
        
        
        lblmedallion.text = dataofReport.objectForKey("medallionNo") as? String
        lblcategory.text = dataofReport.objectForKey("typeofcomplaint") as? String
        imgstatus.layer.cornerRadius = 7
        let status = dataofReport.objectForKey("status") as! Int
        
        switch(status)
        {
        case 0:
            
            imgstatus.backgroundColor = UIColor.greenColor()
            txttitle.text = "SUBMITTED TO 311"
            break
        case 1:
            
            imgstatus.backgroundColor = UIColor.blackColor()
            txttitle.text = "RESOLVED"
            break
            
        case 2:
            
            imgstatus.backgroundColor = UIColor.blueColor()
            txttitle.text = "NOT SUBMITTED"
            break
            
        case 3:
            
            imgstatus.backgroundColor = UIColor.redColor()
            txttitle.text = "DELETED"
            break
        case 4:
            
            imgstatus.backgroundColor = UIColor.yellowColor()
            txttitle.text = "DRAFT"
            break
            
        default:
            
            
            imgstatus.backgroundColor = UIColor.greenColor()
            txttitle.text = "SUBMITTED TO 311"
            break
        }
        
        var stLatitude = dataofReport.objectForKey("latitude") as! NSString
        
        
        var stLongitude = dataofReport.objectForKey("longitude") as! NSString
        
        var doubleLongitude : Double = stLongitude.doubleValue
        var doubleLatitude : Double = stLatitude.doubleValue
        
        
        let center = CLLocationCoordinate2D(latitude: doubleLatitude, longitude: doubleLongitude)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        Map.setRegion(region, animated: true)
        
        
        
        var anotation :MKPointAnnotation = MKPointAnnotation()
        
        anotation.coordinate = center
        anotation.title = "Taxi location"
        anotation.subtitle = "This is the location !!!"
        
        Map.addAnnotation(anotation)

        
        // Do any additional setup after loading the view.
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
        
        
        
    }
    
    @IBAction func clicktwshare(sender: AnyObject) {
        
        
        
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
