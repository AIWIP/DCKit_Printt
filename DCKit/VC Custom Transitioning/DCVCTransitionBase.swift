//
//  XEEVCBaseAnimation.swift
//  TimePrep
//
//  Created by Marko Strizic on 21/10/14.
//  Copyright (c) 2014 XEE Tech. All rights reserved.
//

import UIKit

public enum DCVCTransitionType {
    case appear
    case dissappear
}


open class DCVCTransitionBase:NSObject, UIViewControllerAnimatedTransitioning {
    
    open fileprivate(set) var transitionType:DCVCTransitionType
    
    public init(transitionType:DCVCTransitionType) {
        self.transitionType = transitionType
        super.init()
    }
    
    
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        assert(true, "animateTransition: should be handled by subclass of BaseAnimation");

    }
    
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        assert(true, "animateTransition: should be handled by subclass of BaseAnimation");
        
        return 1;
    }
    
}


