//
//  XEECurrentDevice.swift
//  TimePrep
//
//  Created by Marko Strizic on 17/10/14.
//  Copyright (c) 2014 XEE Tech. All rights reserved.
//

import UIKit

public extension UIDevice {
    
    public var dc_isIpad:Bool {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
            return true
        } else {
            return false
        }
    }
    
    public var dc_isIphone4OrLess:Bool {
        let screenSize = UIScreen.main.bounds.size
        
        let height = max(screenSize.width, screenSize.height)
        
        if height < 568.0 {
            return true
        }
        return false
    }
    
    public var dc_isIphone5OrIpodTouch:Bool {
        let screenSize = UIScreen.main.bounds.size
        
        let height = max(screenSize.width, screenSize.height)
        
        if height == 568.0 {
            return true
        }
        return false
    }
    
    
    public var dc_isIphone6:Bool {
        let screenSize = UIScreen.main.bounds.size
        
        let height = max(screenSize.width, screenSize.height)
        
        if height == 667.0 {
            return true
        }
        return false
    }
    
    public var dc_isIphone6OrNewer:Bool {
        let screenSize = UIScreen.main.bounds.size
        
        let height = max(screenSize.width, screenSize.height)
        
        if height >= 667.0 {
            return true
        }
        return false
    }
    
    public var dc_isIphone6P:Bool {
        let screenSize = UIScreen.main.bounds.size
        
        let height = max(screenSize.width, screenSize.height)
        
        if height == 736.0 {
            return true
        }
        return false
    }
    
}
