//
//  ComplaintTypeViewController.swift
//  taxireport
//
//  Created by Jun Lee on 1/27/15.
//  Copyright (c) 2015  Jun Lee. All rights reserved.
//

import UIKit

class ComplaintTypeViewController: UIViewController {

    
    @IBOutlet var scrollview: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollview.contentSize = CGSizeMake(320,1100);
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

}
