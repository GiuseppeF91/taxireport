//
//  ReportMainTableCell.swift
//  taxireport
//
//  Created by Fang on 1/27/15.
//  Copyright (c) 2015 iOS-Blog. All rights reserved.
//

import UIKit
import MapKit



class ChargeFineCellViewController: UITableViewCell{
    
    
    var lbltitle: UILabel = UILabel()
    var lblcountofcomplaints: UILabel = UILabel()
    var lblpercents: UILabel = UILabel()
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        setupViews()
    }
    
    func setupViews()
    {
        
        
        var screenwidth = UIScreen.mainScreen().bounds.size.width
        
        self.lbltitle.frame = CGRectMake(8, 7, 280, 21)
        self.lbltitle.font = UIFont(name: "GothamRounded-Medium", size: 15)
        
        self.lblcountofcomplaints.frame = CGRectMake(29, 35, 130, 21)
        self.lblcountofcomplaints.font = UIFont(name: "GothamRounded-Book", size: 12)
        self.lblpercents.frame = CGRectMake(screenwidth/2+20, 35, 130, 21)
        self.lblpercents.font = UIFont(name: "GothamRounded-Book", size: 12)
        
       
        
        self.contentView.addSubview(self.lbltitle)
        self.contentView.addSubview(lblcountofcomplaints)
        self.contentView.addSubview(lblpercents)
        
        
        
        let imgright = UIImageView(image: UIImage(named: "blueright"))
        imgright.frame = CGRectMake(screenwidth-25, 22, 15, 22)
        self.contentView.addSubview(imgright)
        
        let imgredalert = UIImageView(image: UIImage(named: "redalert"))
        imgredalert.frame = CGRectMake(8, 39, 13, 13)
        self.contentView.addSubview(imgredalert)
        
        let imggreenalert = UIImageView(image: UIImage(named: "greenalert"))
        imggreenalert.frame = CGRectMake(screenwidth/2, 39, 13, 13)
        self.contentView.addSubview(imggreenalert)
        
        
    }
    
    
    
}
