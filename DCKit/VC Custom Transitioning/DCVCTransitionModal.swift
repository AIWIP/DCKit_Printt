//
//  DCModalSimpleAnimation.swift
//  CroTourism
//
//  Created by Marko Strizic on 09/06/15.
//  Copyright (c) 2015 DeCode. All rights reserved.
//

import UIKit

public class DCVCTransitionModal: DCVCTransitionBase {
   
    public var springDamping:CGFloat                = 1
    public var springVelocity:CGFloat               = 5
    public var durationAppearing:NSTimeInterval     = 1
    public var durationDissappearing:NSTimeInterval = 1

    
    override public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        guard let containerView = transitionContext.containerView() else {
            fatalError("Containerview should be present")
        }
        
        let fromViewVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let fromView = fromViewVC.view
        
        let toViewVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let toView = toViewVC.view
        toView.translatesAutoresizingMaskIntoConstraints = true
        
        let toViewFinalFrame = transitionContext.finalFrameForViewController(toViewVC)
        
        let animationDuration = self.transitionDuration(transitionContext)
        
        let fromViewSnapshot = fromView.snapshotViewAfterScreenUpdates(false)
        fromViewSnapshot.frame = fromView.frame
//        fromView.removeFromSuperview()
        
        if transitionType == .Appear {
            
            containerView.addSubview(fromViewSnapshot)
            containerView.addSubview(toView)
            
            toView.frame.offsetInPlace(dx: 0, dy: containerView.frame.height)
            
            UIView.animateWithDuration(animationDuration, delay: 0, usingSpringWithDamping: springDamping, initialSpringVelocity: springVelocity, options: UIViewAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
                
                toView.frame = toViewFinalFrame
                
            },completion: { (finished) -> Void in
                fromViewSnapshot.removeFromSuperview()
                transitionContext.completeTransition(true)
            })
        }else if transitionType == .Dissappear {
            
            containerView.addSubview(toView)
            containerView.addSubview(fromViewSnapshot)
            
            toView.frame = toViewFinalFrame
            
            let finalAnimationFrame = fromViewSnapshot.frame.offsetBy(dx: 0, dy: containerView.frame.height)
            
            UIView.animateWithDuration(animationDuration, delay: 0, usingSpringWithDamping: springDamping, initialSpringVelocity: springVelocity, options: UIViewAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
                
                fromViewSnapshot.frame = finalAnimationFrame
                
            }, completion: { (finished) -> Void in
                fromViewSnapshot.removeFromSuperview()
                transitionContext.completeTransition(true)
            })
        }
        
    }
    
    override public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        
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
