//
//  UIView+DCFrame.swift
//  DCKit
//
//  Created by Vladimir Kolbas on 9/1/15.
//  Copyright (c) 2015 Vladimir Kolbas. All rights reserved.
//

import UIKit

public extension UIView {
    
    
    public var dc_x : CGFloat {
        get {
            return frame.origin.x
        }
        set {
            var _frame = frame
            _frame.origin.x = newValue
            frame = _frame
        }
    }
    
    public var dc_y : CGFloat {
        get {
            return frame.origin.y
        }
        set {
            var _frame = frame
            _frame.origin.y = newValue
            frame = _frame
        }
    }

    public var dc_height : CGFloat {
        get {
            return frame.size.height
        }
        set {
            var _frame = frame
            _frame.size.height = newValue
            frame = _frame
        }
    }
    
    public var dc_width : CGFloat {
        get {
            return frame.size.width
        }
        set {
            var _frame = frame
            _frame.size.width = newValue
            frame = _frame
        }
    }
    
    public var dc_centerX : CGFloat {
        get {
            return center.x
        }
        set {
            var _center = self.center
            _center.x = newValue
            self.center = _center
        }
    }
    
    public var dc_centerY : CGFloat {
        get {
            return center.y
        }
        set {
            var _center = center
            _center.y = newValue
            center = _center
        }
    }
    
    public var dc_xRight : CGFloat {
        get {
            return frame.origin.x + frame.size.width
        }
        set {
            dc_width = newValue - dc_x
        }
    }

    public var dc_yBottom : CGFloat {
        get {
            return frame.origin.y + frame.size.height
        }
        set {
            dc_height = newValue - dc_y
        }
    }
    

}