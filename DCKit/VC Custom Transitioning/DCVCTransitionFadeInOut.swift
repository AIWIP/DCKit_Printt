//
//  XEEFadeInOutAnimation.swift
//  TimePrep
//
//  Created by Marko Strizic on 15/03/15.
//  Copyright (c) 2015 XEE Tech. All rights reserved.
//

import UIKit

public class DCVCTransitionFadeInOut: DCVCTransitionBase {
    
    public var springDamping:CGFloat                = 0.9
    public var springVelocity:CGFloat               = 8
    public var durationAppearing:NSTimeInterval     = 1
    public var durationDissappearing:NSTimeInterval = 1
    
    override public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView()
        
        let fromViewVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toViewVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        
        let toView = toViewVC.view
        let fromView = fromViewVC.view
        
        let animationDuration = self.transitionDuration(transitionContext)
        
        containerView.addSubview(toView)

        toView.alpha = 0
        
        UIView.animateWithDuration(animationDuration, delay: 0, usingSpringWithDamping: springDamping, initialSpringVelocity: springVelocity, options: UIViewAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
            fromView.alpha = 0
        },completion: { (finished) -> Void in
            UIView.animateWithDuration(animationDuration, delay: 0, usingSpringWithDamping: self.springDamping, initialSpringVelocity: self.springVelocity, options: UIViewAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
                toView.alpha = 1
            },completion: { (finished) -> Void in
                fromView.removeFromSuperview()
                transitionContext.completeTransition(true)
            })
        })
        
    }
    
    override public func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        
        var duration:NSTimeInterval = 0
        
        switch transitionType {
        case .Appear:
            duration = durationAppearing
        case .Dissappear:
            duration = durationDissappearing
        }
        return duration
    }

   
}
