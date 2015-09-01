//
//  UIResponder+KeyboardCache.swift
//  DCKit
//
//  Created by Marko Strizic on 13/05/15.
//  Copyright (c) 2015 DeCode. All rights reserved.
//

import UIKit

public extension UIResponder {
    
    
    private static var hasAlreadyCachedKeyboard = false
    
    public class func dc_cacheKeyboard() {
        
        dc_cacheKeyboard(onNextRunloop: false)
    }
    
    
    public class func dc_cacheKeyboard(#onNextRunloop:Bool) {
        
        if hasAlreadyCachedKeyboard == false {
            hasAlreadyCachedKeyboard = true
            if onNextRunloop {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0), dispatch_get_main_queue(), { () -> Void in
                    self._cacheKeyboard()
                })
            }else{
                _cacheKeyboard()
            }
        }
    }
    
    //MARK: Private
    
    
    class func _cacheKeyboard() {
        
        let field = UITextField()
        UIApplication.sharedApplication().windows.last?.addSubview(field)
        field.becomeFirstResponder()
        field.resignFirstResponder()
        field.removeFromSuperview()
    }

}