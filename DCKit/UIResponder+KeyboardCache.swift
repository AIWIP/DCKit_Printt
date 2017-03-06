//
//  UIResponder+KeyboardCache.swift
//  DCKit
//
//  Created by Marko Strizic on 13/05/15.
//  Copyright (c) 2015 DeCode. All rights reserved.
//

import UIKit

public extension UIResponder {
    
    
    fileprivate static var hasAlreadyCachedKeyboard = false
    
    public class func dc_cacheKeyboard() {
        
        dc_cacheKeyboard(onNextRunloop: false)
    }
    
    
    public class func dc_cacheKeyboard(onNextRunloop:Bool) {
        
        if hasAlreadyCachedKeyboard == false {
            hasAlreadyCachedKeyboard = true
            if onNextRunloop {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(0) / Double(NSEC_PER_SEC), execute: { () -> Void in
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
        UIApplication.shared.windows.last?.addSubview(field)
        field.becomeFirstResponder()
        field.resignFirstResponder()
        field.removeFromSuperview()
    }

}
