//
//  XEEFadeInOutAnimation.swift
//  TimePrep
//
//  Created by Marko Strizic on 15/03/15.
//  Copyright (c) 2015 XEE Tech. All rights reserved.
//

import UIKit

open class DCVCTransitionFadeInOut: DCVCTransitionBase {
    
    open var springDamping:CGFloat                = 0.9
    open var springVelocity:CGFloat               = 8
    open var durationAppearing:TimeInterval     = 1
    open var durationDissappearing:TimeInterval = 1
    
    override open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        let fromViewVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        
        let toView = toViewVC.view!
        let fromView = fromViewVC.view!
        
        let animationDuration = self.transitionDuration(using: transitionContext)
        
        containerView.addSubview(toView)

        toView.alpha = 0
        
        UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: springDamping, initialSpringVelocity: springVelocity, options: UIViewAnimationOptions.beginFromCurrentState, animations: { () -> Void in
            fromView.alpha = 0
        },completion: { (finished) -> Void in
            UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: self.springDamping, initialSpringVelocity: self.springVelocity, options: UIViewAnimationOptions.beginFromCurrentState, animations: { () -> Void in
                toView.alpha = 1
            },completion: { (finished) -> Void in
                fromView.removeFromSuperview()
                transitionContext.completeTransition(true)
            })
        })
        
    }
    
    override open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        var duration:TimeInterval = 0
        
        switch transitionType {
        case .appear:
            duration = durationAppearing
        case .dissappear:
            duration = durationDissappearing
        }
        return duration
    }

   
}
