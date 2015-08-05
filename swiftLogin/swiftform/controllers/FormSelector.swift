//
//  FormSelector.swift
//  SwiftForms
//
//  Created by Jun Lee on 23/08/14.
//  Copyright (c) 2014 Jun Lee. All rights reserved.
//

import UIKit

@objc protocol FormSelector: NSObjectProtocol {
    var formCell: FormBaseCell! { get set }
}
