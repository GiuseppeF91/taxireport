//
//  GeoLocationViewController.swift
//  swiftLogin
//
//  Created by Fang on 1/20/15.
//  Copyright (c) 2015 iOS-Blog. All rights reserved.
//

import UIKit
import MapKit


class GeoLocationViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate ,UITextFieldDelegate,NSURLConnectionDelegate{

    
    
    @IBOutlet weak var Map: MKMapView!
    var anotation = MKPointAnnotation()
    @IBOutlet var srcScrollView: UIScrollView!
    lazy var data = NSMutableData()
    
    @IBOutlet weak var locationText: UITextField!
    
    @IBOutlet weak var timeText: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var dateView: UIView!
    
    
    var activeTextField:UITextField!
    var locationManager = CLLocationManager()
    var locationFixAchieved : Bool = false
    var coordinatemap :CLLocation!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 250.0/255.0, green: 199.0/255.0, blue: 26.0/255.0, alpha: 1.0)
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        switch UIDevice.currentDevice().systemVersion.compare("8.0.0", options: NSStringCompareOptions.NumericSearch) {
        case .OrderedSame, .OrderedDescending:
            locationManager.requestAlwaysAuthorization()
        case .OrderedAscending:
            println("iOS < 8.0")
        }
        dateView.hidden = true
        
        locationManager.startUpdatingLocation()
        
     
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy, h:mm" // superset of OP's format
        let str = dateFormatter.stringFromDate(NSDate())
        
        self.timeText.text = str
        

        
        locationText.delegate = self
        activeTextField = locationText
        srcScrollView.contentSize = self.view.frame.size
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
   
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.registerForKeyboardNotifications()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]) {
        if (locationFixAchieved == false) {
            locationFixAchieved = true
            coordinatemap = locations.last as CLLocation
            
            let center = CLLocationCoordinate2D(latitude: coordinatemap.coordinate.latitude, longitude: coordinatemap.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            self.Map.setRegion(region, animated: true)
            
            
            
            
            anotation.coordinate = coordinatemap.coordinate
            anotation.title = "Taxi location"
            anotation.subtitle = "This is the location !!!"
          
         
            
            
            self.Map.addAnnotation(anotation)
            
        }
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


   
    func registerForKeyboardNotifications() {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self,
            selector: "keyboardWillBeShown:",
            name: UIKeyboardWillShowNotification,
            object: nil)
        notificationCenter.addObserver(self,
            selector: "keyboardWillBeHidden:",
            name: UIKeyboardWillHideNotification,
            object: nil)
    }
    
    // Called when the UIKeyboardDidShowNotification is sent.
    func keyboardWillBeShown(sender: NSNotification) {
        let info: NSDictionary = sender.userInfo!
        let value: NSValue = info.valueForKey(UIKeyboardFrameBeginUserInfoKey) as NSValue
        let keyboardSize: CGSize = value.CGRectValue().size
        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0)
        srcScrollView.contentInset = contentInsets
        srcScrollView.scrollIndicatorInsets = contentInsets
        
        var scframe = srcScrollView.frame;
        scframe.size.height -= keyboardSize.height
        
        // If active text field is hidden by keyboard, scroll it so it's visible
        // Your app might not need or want this behavior.
        var aRect: CGRect = self.view.frame
        aRect.size.height -= keyboardSize.height
        var activeTextFieldRect: CGRect? = activeTextField?.frame
        let activeTextFieldOrigin: CGPoint? = activeTextFieldRect?.origin
     
        srcScrollView.scrollRectToVisible(scframe, animated:true)
        scframe.size.height += 50;
        srcScrollView.frame = scframe;

    }
    
    // Called when the UIKeyboardWillHideNotification is sent
    func keyboardWillBeHidden(sender: NSNotification) {
        let contentInsets: UIEdgeInsets = UIEdgeInsetsZero
        srcScrollView.contentInset = contentInsets
        srcScrollView.scrollIndicatorInsets = contentInsets
        srcScrollView.frame = self.view.frame
        var locationTogeo:String = locationText.text
        
        locationTogeo = CFURLCreateStringByAddingPercentEscapes(
            nil,
            locationTogeo,
            nil,
            "!*'();:@&=+$,/?%#[]",
            CFStringBuiltInEncodings.UTF8.rawValue
        )
        

        
        var urlPath : String = String(format: "http://maps.google.com/maps/api/geocode/json?address=%@,nyc&components=country:US", locationTogeo)
        
        
        
        
        
        var url: NSURL = NSURL(string: urlPath)!
        var request: NSURLRequest = NSURLRequest(URL: url)
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)!
        connection.start()
        SVProgressHUD.showInfoWithStatus("Search location", maskType: SVProgressHUDMaskType.Black)
        
        
        
        
    }
    
    
    func textFieldDidBeginEditing(textField: UITextField!) {
        activeTextField = textField
        srcScrollView.scrollEnabled = true
    }
    
    func textFieldDidEndEditing(textField: UITextField!) {
        activeTextField = nil
        srcScrollView.scrollEnabled = false
    }
    func textFieldShouldReturn(textField: UITextField!) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    

    func connection(connection: NSURLConnection!, didReceiveData data: NSData!){
        self.data.appendData(data)
    }

    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        
        
        
        var err: NSError
        // throwing an error on the line below (can't figure out where the error message is)
        var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
        println(jsonResult)
        
        self.data = NSMutableData()
        
        // 4
        let jsonresults: NSArray! = jsonResult["results"] as NSArray
        let stateresult = jsonResult["status"] as String
        if (stateresult == "OK")
        {
            let addressresult: NSDictionary! = jsonresults.objectAtIndex(0) as NSDictionary
            let geometrydata: NSDictionary! = addressresult["geometry"] as NSDictionary
            let locationdata: NSDictionary! = geometrydata["location"] as NSDictionary
            
            let doubleLatitude : Double = locationdata["lat"] as Double
            let doubleLongitude : Double = locationdata["lng"] as Double
            
            
            
            
            
            let center = CLLocationCoordinate2D(latitude: doubleLatitude, longitude: doubleLongitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            self.Map.setRegion(region, animated: true)
            
            
            
            
            self.anotation.coordinate = center
            self.anotation.title = "Taxi location"
            self.anotation.subtitle = "This is the location !!!"
            
            
            
            
            self.Map.addAnnotation(self.anotation)
            
            SVProgressHUD.dismiss()
            
            
        }else
        {
            SVProgressHUD.dismiss()
            var alertview:UIAlertView = UIAlertView(title: "Ooop", message: "Please input valide address", delegate: nil, cancelButtonTitle: "OK")
            alertview.show()
            return

        }

        
        
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
    
    @IBAction func clickDatePicker(sender: AnyObject) {
        dateView.hidden = false
        
        self.view.endEditing(true)
        
    }
    
    @IBAction func clickDone(sender: AnyObject) {
        dateView.hidden = true
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy, h:mm" // superset of OP's format
        
        var strDate = dateFormatter.stringFromDate(datePicker.date)
        timeText.text = strDate
        
        
        
    }
    
    
    @IBAction func clicknext(sender:AnyObject)
    {
        var appdelegate : AppDelegate
        
        appdelegate = UIApplication.sharedApplication().delegate as AppDelegate
        appdelegate.longitude = String(format: "%f", anotation.coordinate.longitude)
        appdelegate.latitude = String(format: "%f", anotation.coordinate.latitude)
        appdelegate.timeofreport = NSDate()
        
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        
        if (appdelegate.selectedReport == 0)
        {
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("complimentdetail") as UIViewController
        }else
        {
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("complaintdetail") as UIViewController
            
            
        }
        
        self.navigationController?.pushViewController(destViewController, animated: true)
        
    }
    

}
