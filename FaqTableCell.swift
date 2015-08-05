//
//  FaqTableCell.swift
//  taxireport
//
//  Created by Fang on 2/7/15.
//  Copyright (c) 2015 iOS-Blog. All rights reserved.
//

import UIKit

class FaqTableCell: UITableViewCell {
   
    var lbltitle: UILabel = UILabel()
    var lbldescription: UILabel = UILabel()
    var lineview: UIView = UIView()
    
    var titlefont:UIFont = UIFont(name: "GothamRounded-Medium", size: 16)!;
    var descfont:UIFont = UIFont(name: "GothamRounded-Book", size: 14)!;
    
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
        
        
        
        lbltitle.numberOfLines = 0
        lbltitle.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        lbltitle.font = titlefont
        
        
        lineview.backgroundColor = UIColor.lightGrayColor()
        
        lbldescription.lineBreakMode = NSLineBreakMode.ByWordWrapping
        lbldescription.numberOfLines = 0
        lbldescription.font = descfont
        
        
        self.contentView.addSubview(lbltitle)
        self.contentView.addSubview(lbldescription)
        self.contentView.addSubview(lineview)
        
        
        
    }

    
    
}
