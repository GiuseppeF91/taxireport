//
//  FaqViewController.swift
//  swiftLogin
//
//  Created by Fang on 1/20/15.
//  Copyright (c) 2015 iOS-Blog. All rights reserved.
//

import UIKit

class FaqViewController: UIViewController {

    var faqArray : NSArray = []
    var titlefont:UIFont = UIFont(name: "GothamRounded-Medium", size: 16)!;
    var descfont:UIFont = UIFont(name: "GothamRounded-Book", size: 14)!;
    
    
    var tmplabel:UILabel!
    
    var tmplabel1:UILabel!
    
    var heighttitleArray = NSMutableArray()
    var heightdescArray = NSMutableArray()
    
    
    var transitionOperator = TransitionOperator()
    
    @IBOutlet var container:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let screenwidth = UIScreen.mainScreen().bounds.size.width
    
        
        tmplabel = UILabel(frame: CGRectMake(8, 0, screenwidth-28, CGFloat.max))
        tmplabel1 = UILabel(frame: CGRectMake(8, 0, screenwidth-28, CGFloat.max))
        
        self.view.backgroundColor = UIColor(red: 250.0/255.0, green: 199.0/255.0, blue: 26.0/255.0, alpha: 1.0)
        
        self.navigationController?.navigationBar.hidden = true
        
         self.container.registerClass(FaqTableCell.self, forCellReuseIdentifier: "mycell")
        
        var query :PFQuery = PFQuery(className: "faq")
        query.orderByDescending("createdAt")
        SVProgressHUD .showWithStatus("Loading...", maskType: SVProgressHUDMaskType.Black)
        query.findObjectsInBackgroundWithBlock({(NSArray objects, NSError error) in
            
            SVProgressHUD.dismiss()
            if (error != nil) {
                NSLog("error " + error.localizedDescription)
            }
            else {
                NSLog("objects %@", objects as NSArray)
                self.faqArray = objects
                
                var tempdic:PFObject
                
                for tempdic  in objects {
                    
                    
                    var faqdescription :String = tempdic.objectForKey("faqdescription") as String
                    
                    var title : String = tempdic.objectForKey("title") as String
                    
                    var titlewidth = self.heightForView(title, font: self.titlefont, width: 288) as CGFloat
                    
                    var descwidth = self.heightForView1(faqdescription, font: self.descfont, width: 288) as CGFloat
                    
                    
                    self.heighttitleArray.addObject(titlewidth)
                    self.heightdescArray.addObject(descwidth)
                }
                
                
                
                
                self.container.reloadData()
                
            }
        })

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func toggleSideMenu(sender: AnyObject) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var toViewController : UITableViewController
        
        toViewController = mainStoryboard.instantiateViewControllerWithIdentifier("sidebar") as UITableViewController
        
        self.modalPresentationStyle = UIModalPresentationStyle.Custom
        toViewController.transitioningDelegate = self.transitionOperator
        self .presentViewController(toViewController, animated: true) { () -> Void in
            
            
        }
        
    }
    
    
    /* table view delegate
    
    */
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:FaqTableCell = tableView.dequeueReusableCellWithIdentifier("mycell") as FaqTableCell
        
      
        
        var screenwidth = UIScreen.mainScreen().bounds.size.width
        
        
        
        var object: PFObject = self.faqArray.objectAtIndex(indexPath.section)
            as PFObject
        
        var faqdescription = object.objectForKey("faqdescription") as? String
        var title = object.objectForKey("title") as? String
        
        
                
        var titlewidth = heighttitleArray.objectAtIndex(indexPath.section) as CGFloat
        
        cell.lbltitle.frame = CGRectMake(8, 8, screenwidth-28, titlewidth)
        cell.lbltitle.text = title
        cell.lineview.frame = CGRectMake(0, titlewidth+17, screenwidth, 2)
        
        
        var descwidth = heightdescArray.objectAtIndex(indexPath.section) as CGFloat
        
        
        cell.lbldescription.frame = CGRectMake(8, 27+titlewidth, screenwidth-28, descwidth)
        cell.lbldescription.text = faqdescription
        
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        
        cell.lbltitle.sizeToFit()
        cell.lbldescription.sizeToFit()
        return cell
    }
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        
        tmplabel.numberOfLines = 0
        tmplabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        tmplabel.font = titlefont
        tmplabel.text = text
        
        tmplabel.sizeToFit()
        return tmplabel.frame.height
    }
    
    func heightForView1(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        
        tmplabel1.numberOfLines = 0
        tmplabel1.lineBreakMode = NSLineBreakMode.ByWordWrapping
        tmplabel1.font = descfont
        tmplabel1.text = text
        
        tmplabel1.sizeToFit()
        return tmplabel1.frame.height
    }
    
   
   
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
     
        
        
        
        
    }
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var titlewidth = heighttitleArray.objectAtIndex(indexPath.section) as CGFloat
        
        var descwidth = heightdescArray.objectAtIndex(indexPath.section) as CGFloat
        
        
        
        return titlewidth+descwidth+30
    }
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return self.faqArray.count
    
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
