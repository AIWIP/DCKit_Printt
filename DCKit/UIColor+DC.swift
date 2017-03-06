//
//  UIColor+DC.swift
//  DCKit
//
//  Created by Marko Strizic on 13/05/15.
//  Copyright (c) 2015 DeCode. All rights reserved.
//

import UIKit


public extension UIColor {
    
    public convenience init(dc_hexValue: UInt64) {
        self.init(red: ((CGFloat)((dc_hexValue & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((dc_hexValue & 0xFF00) >> 8))/255.0, blue: ((CGFloat)(dc_hexValue & 0xFF))/255.0, alpha: 1)
    }
    
    public class func dc_colorFromHexValue(_ hexValue:UInt64) -> UIColor {
        let color = UIColor(red: ((CGFloat)((hexValue & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((hexValue & 0xFF00) >> 8))/255.0, blue: ((CGFloat)(hexValue & 0xFF))/255.0, alpha: 1)
        return color;
    }
}
