//
//  UIViewController+CustomTransitioning.swift
//  CroTourism
//
//  Created by Marko Strizic on 26/05/15.
//  Copyright (c) 2015 DeCode. All rights reserved.
//

import UIKit


private var kCustomTransitioningHelperID: UInt8 = 0

private class DCCustomTransitioningHelper : NSObject {
    
    var appearAnimation:DCVCTransitionBase?
    var dissappearAnimation:DCVCTransitionBase?
    
}


public extension UIViewController {
    
    /** Animation object which will be used when performing custom transitioning. Used often for appearing animations.
    Example: When UIViewController is pushed to UINavigationController stack
    */
    public var dc_appearAnimation:DCVCTransitionBase? {
        set{
            getCustomTransitionHelper().appearAnimation = newValue
        }
        get{
            return getCustomTransitionHelper().appearAnimation
        }
    }
    
    /** Animation object which will be used when performing custom transitioning. Used often for dissapearing animations.
    Example: When UIViewController is popped from UINavigationController stack
    */
    public var dc_dissappearAnimation:DCVCTransitionBase? {
        set{
            getCustomTransitionHelper().dissappearAnimation = newValue
        }
        get{
            return getCustomTransitionHelper().dissappearAnimation
        }
    }
    
    fileprivate func getCustomTransitionHelper() -> DCCustomTransitioningHelper {
        
        var helper = objc_getAssociatedObject(self, &kCustomTransitioningHelperID) as? DCCustomTransitioningHelper
        
        if helper == nil {
            helper = DCCustomTransitioningHelper()
            objc_setAssociatedObject(self, &kCustomTransitioningHelperID, helper, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        return helper!
    }
    
}
