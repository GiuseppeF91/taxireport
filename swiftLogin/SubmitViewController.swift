//
//  SubmitViewController.swift
//  swiftLogin
//
//  Created by Fang on 1/20/15.
//  Copyright (c) 2015 iOS-Blog. All rights reserved.
//

import UIKit
import MediaPlayer
import MobileCoreServices
import AVFoundation
class SubmitViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate,AVAudioRecorderDelegate,UIActionSheetDelegate{

    
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var PictureBtn: UIButton!
    
    
    @IBOutlet weak var recordLable: UILabel!
    
    
    @IBOutlet weak var passengerSwitch: UISwitch!
    
    var photoData:UIImage!
    var videoUrl:NSURL!
    var soundFileURL:NSURL?
    
    
    var picker:UIImagePickerController=UIImagePickerController()
    var popover:UIPopoverController?=nil
    
    var selectIndex:Int = 0
    
    var recorder: AVAudioRecorder!
    
    var player:AVAudioPlayer!
    var meterTimer:NSTimer!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        

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
    
    @IBAction func clickpicture(sender: AnyObject) {
        
        self.view .endEditing(true)
        var actionSheet:UIActionSheet
        
        
        actionSheet = UIActionSheet(title: "select media", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil,otherButtonTitles:"Video", "Picture")
        actionSheet.showInView(self.view)
        
        
        
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        
        
        if( buttonIndex == 1){
            self.openCamera()
            
        } else if(buttonIndex == 2){
            self.openGallary()
        } else {
            
        }
        
    }
    
    
    func openCamera()
    {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            selectIndex = 0
            
            println("captureVideoPressed and camera available.")
            
            var imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType = .Camera;
            imagePicker.mediaTypes = [kUTTypeMovie!]
            imagePicker.allowsEditing = false
            
            imagePicker.showsCameraControls = true
            
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
            
        }
            
        else {
            println("Camera not available.")
        }
        
    }
    func openGallary()
    {
        
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera))
        {
            selectIndex = 1
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            self .presentViewController(picker, animated: true, completion: nil)
        }
       
        
        
        
        
    }
    
    func imagePickerController(  didFinishPickingMediaWithInfo info:NSDictionary!) {
        if (selectIndex == 0)
        {
            videoUrl = info[UIImagePickerControllerMediaURL] as! NSURL!
            let pathString = videoUrl.relativePath
            self.dismissViewControllerAnimated(true, completion: {})
        
            self.PictureBtn.setTitle("video attached", forState: .Normal)
            photoData = nil
        }else
        {
            photoData  = info[UIImagePickerControllerOriginalImage] as! UIImage
            self.dismissViewControllerAnimated(true, completion: nil)
            
            self.PictureBtn.setTitle("Picture attached", forState: .Normal)
            videoUrl = nil
            
        }
    }
    
    
    
    @IBAction func clickaudio(sender: AnyObject) {
        
        self.view .endEditing(true)
        
        if recorder == nil {
            println("recording. recorder nil")
            recordWithPermission(true)
            return
        }
        
        if recorder != nil && recorder.recording {
            self.stop()
            
        } else {
            println("recording")
            //            recorder.record()
            recordWithPermission(false)
        }

        
        
        
    }
    
    @IBAction func clicknext(sender:AnyObject)
    {
        
        if (self.descriptionText.text.isEmpty)
        {
            var alertview:UIAlertView = UIAlertView(title: "Ooop", message: "Please write description", delegate: nil, cancelButtonTitle: "OK")
            alertview.show()
            return

        }
        if (recorder != nil)
        {
            if recorder != nil && recorder.recording {
                self.stop()
                
            }
        }
        
        var appdelegate : AppDelegate
        
        appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appdelegate.reportDescription = self.descriptionText.text
        appdelegate.photoData = self.photoData
        appdelegate.videoData = self.videoUrl
        appdelegate.audioData = self.soundFileURL
        appdelegate.passenger = self.passengerSwitch.on
        
        
        
        SVProgressHUD.showWithStatus("Loading", maskType: .Black)
        
        
        var query :PFQuery = PFQuery(className: "submission")
        
        var object_submission = PFObject(className: "submission")
        object_submission.setObject(appdelegate.medallionNo, forKey: "medallionNo")
        object_submission.setObject(appdelegate.latitude, forKey: "latitude")
        object_submission.setObject(appdelegate.longitude, forKey: "longitude")
        object_submission.setObject(appdelegate.timeofreport, forKey: "timeofreport")
        object_submission.setObject(appdelegate.selectedReport, forKey: "selectedReport")
        object_submission.setObject(Int(0), forKey: "status")
        object_submission.setObject(appdelegate.typeofcomplaint, forKey: "typeofcomplaint")
        object_submission.setObject(appdelegate.reportDescription, forKey: "reportDescription")
        object_submission.setObject(appdelegate.passenger, forKey: "passenger")
        if (appdelegate.photoData != nil)
        {
            var resizeImage:UIImage = self.RBResizeImage(appdelegate.photoData!, targetSize: CGSizeMake(320, 480))
            
            var imageFile:PFFile = PFFile(data: UIImageJPEGRepresentation(resizeImage, 1))
        
            object_submission.setObject(imageFile, forKey: "photoData")
        
        }
        
        if (appdelegate.videoData != nil)
        {
            
            let data1: NSData? = NSData(contentsOfURL: appdelegate.videoData!)
            
            if (data1?.length > 2048000)
            {
                var alertview:UIAlertView = UIAlertView(title: "Ooop", message: "video file must be less than 2Mb", delegate: nil, cancelButtonTitle: "OK")
                alertview.show()
                SVProgressHUD.dismiss()
                return
            }
            
            var videofile:PFFile = PFFile(data:data1)
                
            object_submission.setObject(videofile, forKey: "videoData")
        }
        
        if (appdelegate.audioData != nil)
        {
            
            let data1: NSData? = NSData(contentsOfURL: appdelegate.audioData!)
            
            var audiofile:PFFile = PFFile(data:data1)
            
            if (data1?.length > 2048000)
            {
                var alertview:UIAlertView = UIAlertView(title: "Ooop", message: "audio file must be less than 2Mb", delegate: nil, cancelButtonTitle: "OK")
                alertview.show()
                SVProgressHUD.dismiss()
                return
            }
            
            object_submission.setObject(audiofile, forKey: "audioData")
            
        }
        
        object_submission.saveInBackgroundWithBlock({(success: Bool, error: NSError!) -> Void in
            SVProgressHUD.dismiss()
            appdelegate.photoData = nil
            appdelegate.videoData = nil
            appdelegate.audioData = nil
            if (success)
            {
                var alertview:UIAlertView = UIAlertView(title: "Thank You", message: "Your report has been received and we will start the process of submitting it to 311 on your behalf.", delegate: nil, cancelButtonTitle: "OK")
                alertview.show()

                var destViewController : MyNavigationController
            
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
            
                destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("mynav") as! MyNavigationController
            
            
                appdelegate.submitReport = true
                appdelegate.window?.rootViewController = destViewController;
            }else
            {
                var alertview:UIAlertView = UIAlertView(title: "Ooop", message: "Submit data fail.Please check internet connection and try again", delegate: nil, cancelButtonTitle: "OK")
                alertview.show()
            }
            
            
        })
        
        
        
       
        
    }
    
    
   
    func RBResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
        } else {
            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func updateAudioMeter(timer:NSTimer) {
        
        if recorder.recording {
            let dFormat = "%02d"
            let min:Int = Int(recorder.currentTime / 60)
            let sec:Int = Int(recorder.currentTime % 60)
            let s = "Recording...\(String(format: dFormat, min)):\(String(format: dFormat, sec)). For stop recording tap here again"
            self.recordLable.text = s
            recorder.updateMeters()
            var apc0 = recorder.averagePowerForChannel(0)
            var peak0 = recorder.peakPowerForChannel(0)
        }
    }
    
    
    
    
    func stop() {
        println("stop")
        recorder.stop()
        meterTimer.invalidate()
        
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        var error: NSError?
        if !session.setActive(false, error: &error) {
            println("could not make session inactive")
            if let e = error {
                println(e.localizedDescription)
                return
            }
        }
        recorder = nil
    }
    
    
    
    func setupRecorder() {
        var format = NSDateFormatter()
        format.dateFormat="yyyy-MM-dd-HH-mm-ss"
        var currentFileName = "recording-\(format.stringFromDate(NSDate())).m4a"
        println(currentFileName)
        
        var dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        var docsDir: AnyObject = dirPaths[0]
        var soundFilePath = docsDir.stringByAppendingPathComponent(currentFileName)
        soundFileURL = NSURL(fileURLWithPath: soundFilePath)
        let filemanager = NSFileManager.defaultManager()
        if filemanager.fileExistsAtPath(soundFilePath) {
            // probably won't happen. want to do something about it?
            println("sound exists")
        }
        
        var recordSettings = [
            AVFormatIDKey: kAudioFormatAppleLossless,
            AVEncoderAudioQualityKey : AVAudioQuality.Max.rawValue,
            AVEncoderBitRateKey : 320000,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey : 44100.0
        ]
        var error: NSError?
        recorder = AVAudioRecorder(URL: soundFileURL!, settings: recordSettings as [NSObject : AnyObject], error: &error)
        if let e = error {
            println(e.localizedDescription)
        } else {
            recorder.delegate = self
            recorder.meteringEnabled = true
            recorder.prepareToRecord() // creates/overwrites the file at soundFileURL
        }
    }
    
    func recordWithPermission(setup:Bool) {
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        // ios 8 and later
        if (session.respondsToSelector("requestRecordPermission:")) {
            AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
                if granted {
                    println("Permission to record granted")
                    self.setSessionPlayAndRecord()
                    if setup {
                        self.setupRecorder()
                    }
                    self.recorder.record()
                    self.meterTimer = NSTimer.scheduledTimerWithTimeInterval(0.1,
                        target:self,
                        selector:"updateAudioMeter:",
                        userInfo:nil,
                        repeats:true)
                } else {
                    println("Permission to record not granted")
                }
            })
        } else {
            println("requestRecordPermission unrecognized")
        }
    }
    
    func setSessionPlayback() {
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        var error: NSError?
        if !session.setCategory(AVAudioSessionCategoryPlayback, error:&error) {
            println("could not set session category")
            if let e = error {
                println(e.localizedDescription)
            }
        }
        if !session.setActive(true, error: &error) {
            println("could not make session active")
            if let e = error {
                println(e.localizedDescription)
            }
        }
    }
    
    func setSessionPlayAndRecord() {
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        var error: NSError?
        if !session.setCategory(AVAudioSessionCategoryPlayAndRecord, error:&error) {
            println("could not set session category")
            if let e = error {
                println(e.localizedDescription)
            }
        }
        if !session.setActive(true, error: &error) {
            println("could not make session active")
            if let e = error {
                println(e.localizedDescription)
            }
        }
    }
    
    func deleteAllRecordings() {
        var docsDir =
        NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        var fileManager = NSFileManager.defaultManager()
        var error: NSError?
        var files = fileManager.contentsOfDirectoryAtPath(docsDir, error: &error) as! [String]
        if let e = error {
            println(e.localizedDescription)
        }
        var recordings = files.filter( { (name: String) -> Bool in
            return name.hasSuffix("m4a")
        })
        for var i = 0; i < recordings.count; i++ {
            var path = docsDir + "/" + recordings[i]
            
            println("removing \(path)")
            if !fileManager.removeItemAtPath(path, error: &error) {
                NSLog("could not remove \(path)")
            }
            if let e = error {
                println(e.localizedDescription)
            }
        }
    }
    
    func askForNotifications() {
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector:"background:",
            name:UIApplicationWillResignActiveNotification,
            object:nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector:"foreground:",
            name:UIApplicationWillEnterForegroundNotification,
            object:nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector:"routeChange:",
            name:AVAudioSessionRouteChangeNotification,
            object:nil)
    }
    
    func background(notification:NSNotification) {
        println("background")
    }
    
    func foreground(notification:NSNotification) {
        println("foreground")
    }
    
    
    func routeChange(notification:NSNotification) {
        
        
    }
    
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!,
        successfully flag: Bool) {
            println("finished recording \(flag)")
            
            
            self.recordLable.text = "Record attached. For re take voice , click here again"
    }
    
    func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder!,
        error: NSError!) {
            println("\(error.localizedDescription)")
    }

    
}
