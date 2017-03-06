//
//  UIDevice+DeviceTypes.swift
//  DCKit
//
//  Created by Vladimir Kolbas on 9/1/15.
//  Copyright (c) 2015 Vladimir Kolbas. All rights reserved.
//

import Foundation

public extension UIDevice {
    
    public var dc_deviceIsIphone : Bool {
        return UIDevice.current.model.hasPrefix("iPhone")
    }
    
    public var dc_deviceIsIpod : Bool {
        return UIDevice.current.model.hasPrefix("iPod")
    }

    public var dc_deviceIsIpad : Bool {
        return UIDevice.current.model.hasPrefix("iPad")
    }

}
