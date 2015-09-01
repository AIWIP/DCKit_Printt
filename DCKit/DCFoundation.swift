//
//  DCFoundation.swift
//  DCKit
//
//  Created by Vladimir Kolbas on 9/1/15.
//  Copyright (c) 2015 Vladimir Kolbas. All rights reserved.
//

import Foundation

public func dc_delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}