//
//  ReportMainTableCell.swift
//  taxireport
//
//  Created by Jun Lee on 1/27/15.
//  Copyright (c) 2015  Jun Lee. All rights reserved.
//

import UIKit
import MapKit

protocol DetailCellDelegate
{
    func detailforCell(indexPath:NSIndexPath )
}

class ReportMainTableCell: UITableViewCell ,MKMapViewDelegate{

    
    var lbldate: UILabel = UILabel()
    var lbldescription: UILabel = UILabel()
    var lblstatus: UILabel = UILabel()
    var btnmore: UIButton = UIButton()
    var imgstatus: UIView  = UIView()
    var maplocation: MKMapView = MKMapView()

    var parentIndex: NSIndexPath!
    
    var delegate:DetailCellDelegate?
    
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
        
        self.imgstatus.frame = CGRectMake(8, 10, 14, 14)
        
        self.lblstatus.frame = CGRectMake(30, 9, 284, 21)
        self.lblstatus.textColor = UIColor.darkGrayColor()
        
        self.maplocation.frame = CGRectMake(0, 33, 300, 107)
        self.maplocation.delegate = self
        self.lbldate.frame = CGRectMake(8, 148, 284, 21)
        
        self.lbldescription.frame = CGRectMake(8, 177, 284, 37)
        self.lbldescription.textColor = UIColor.darkGrayColor()
        self.lbldescription.font = UIFont(name: "System", size: 13)
        self.lbldescription.numberOfLines = 2;
        
        self.btnmore.frame = CGRectMake(0, 215, 300, 56)
        
        self.contentView.addSubview(self.imgstatus)
        self.contentView.addSubview(lblstatus)
        self.contentView.addSubview(maplocation)
        self.contentView.addSubview(lbldate)
        self.contentView.addSubview(lbldescription)
        self.contentView.addSubview(btnmore)
        
        //static views
        let imgmore = UIImageView(image: UIImage(named: "moredetail"))
        imgmore.frame = CGRectMake(8, 224, 25, 25)
        self.contentView.addSubview(imgmore)
        
        let lblmore = UILabel(frame: CGRectMake(40, 226, 223, 21))
        lblmore.text = "More Details"
        lblmore.textColor = UIColor(red: 0, green: 51.0/255.0 , blue: 153.0/255.0, alpha: 1.0)
        self.contentView.addSubview(lblmore)
        
        
        let imgright = UIImageView(image: UIImage(named: "blueright"))
        imgright.frame = CGRectMake(279, 231, 15, 22)
        self.contentView.addSubview(imgright)
        
        
        let lblseperate = UILabel(frame: CGRectMake(0, 215, 320, 1))
        lblseperate.backgroundColor = UIColor.lightGrayColor()
        self.contentView.addSubview(lblseperate)
        
        self.btnmore.addTarget(self, action: "clickDetail:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
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
    
    func clickDetail(sender: AnyObject) {
        delegate?.detailforCell(parentIndex)
        
    }
}
