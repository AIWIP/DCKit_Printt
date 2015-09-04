//
//  NSString+DCFontHeight.swift
//  DCKit
//
//  Created by Vladimir Kolbas on 9/4/15.
//  Copyright (c) 2015 Vladimir Kolbas. All rights reserved.
//

import Foundation

public extension NSString {
    
    public func dc_height(usingFont font:UIFont, constrainedToWidth width:CGFloat) -> CGFloat {
        let constrainedSize = CGSizeMake(width, 1000)
        let attributes = [NSFontAttributeName : font]
        let textRect = self.boundingRectWithSize(constrainedSize, options: .UsesLineFragmentOrigin, attributes: attributes, context: nil)
        return textRect.height
    }
}
