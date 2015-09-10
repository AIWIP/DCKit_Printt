//
//  XEEVCBaseAnimation.swift
//  TimePrep
//
//  Created by Marko Strizic on 21/10/14.
//  Copyright (c) 2014 XEE Tech. All rights reserved.
//

import UIKit

public enum DCVCTransitionType {
    case Appear
    case Dissappear
}


public class DCVCTransitionBase:NSObject, UIViewControllerAnimatedTransitioning {
    
    public private(set) var transitionType:DCVCTransitionType
    
    public init(transitionType:DCVCTransitionType) {
        self.transitionType = transitionType
        super.init()
    }
    
    
    
    public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        assert(true, "animateTransition: should be handled by subclass of BaseAnimation");

    }
    
    public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        
        assert(true, "animateTransition: should be handled by subclass of BaseAnimation");
        
        return 1;
    }
    
}


