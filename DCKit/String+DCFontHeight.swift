//
//  String+DCFontHeight.swift
//  DCKit
//
//  Created by Vladimir Kolbas on 9/4/15.
//  Copyright (c) 2015 Vladimir Kolbas. All rights reserved.
//

import Foundation

public extension String {
    
    public func dc_height(usingFont font:UIFont, constrainedToWidth width:CGFloat) -> CGFloat {
        let converterString:NSString = self as NSString
        let height = converterString.dc_height(usingFont: font, constrainedToWidth: width)
        return height
    }
}
