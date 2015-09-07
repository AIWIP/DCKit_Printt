//
//  XEEHorizontalSplitAnimation.swift
//  TimePrep
//
//  Created by Marko Strizic on 25/11/14.
//  Copyright (c) 2014 XEE Tech. All rights reserved.
//

import UIKit

public class DCVCTransitionHorizontalSplit: DCVCTransitionBase {

    override public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView()
        
        let fromViewVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toViewVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        
        let toView = toViewVC.view
        
        let fromView = fromViewVC.view
        fromView.setTranslatesAutoresizingMaskIntoConstraints(true)

        
        let toViewFinalFrame = transitionContext.finalFrameForViewController(toViewVC)
        
        
        let animationDuration = self.transitionDuration(transitionContext)
        
        if transitionType == .Appear {
            
            var snapshotFrame = CGRectMake(0, 0, fromView.frame.width/2, fromView.frame.height)
            
            
            let leftSnapshot = fromView.resizableSnapshotViewFromRect(snapshotFrame, afterScreenUpdates: false, withCapInsets: UIEdgeInsetsZero)
            leftSnapshot.dc_x = 0
            leftSnapshot.dc_y = fromView.dc_y

            
            snapshotFrame.origin.x = fromView.dc_width/2
            let rightSnapshot = fromView.resizableSnapshotViewFromRect(snapshotFrame, afterScreenUpdates: false, withCapInsets: UIEdgeInsetsZero)
            rightSnapshot.dc_x = fromView.dc_width/2
            rightSnapshot.dc_y = fromView.dc_y
            
            toView.transform = CGAffineTransformMakeScale(0.8, 0.8)
            
            fromView.removeFromSuperview()
            containerView.addSubview(toView)
            containerView.addSubview(leftSnapshot)
            containerView.addSubview(rightSnapshot)
            
            UIView.animateWithDuration(animationDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: UIViewAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
                leftSnapshot.dc_x -= leftSnapshot.dc_width
                rightSnapshot.dc_x += rightSnapshot.dc_width
                toView.transform = CGAffineTransformIdentity

            }, completion: { (finished) -> Void in
                leftSnapshot.removeFromSuperview()
                rightSnapshot.removeFromSuperview()
                transitionContext.completeTransition(true)
            })
            
        }else if transitionType == .Dissappear {
            
            containerView.addSubview(toView)
            
            
            let blankView = UIView()
            blankView.backgroundColor = UIColor.whiteColor()
            blankView.frame = containerView.bounds
            containerView.addSubview(blankView)
            
            var snapshotFrame = CGRectMake(0, 0, fromView.frame.width/2, fromView.frame.height)
            
            let leftSnapshot = toView.resizableSnapshotViewFromRect(snapshotFrame, afterScreenUpdates: true, withCapInsets: UIEdgeInsetsZero)
            leftSnapshot.dc_x = -leftSnapshot.dc_width
            leftSnapshot.dc_y = toView.dc_y
            
            
            snapshotFrame.origin.x = fromView.frame.width/2
            let rightSnapshot = toView.resizableSnapshotViewFromRect(snapshotFrame, afterScreenUpdates: true, withCapInsets: UIEdgeInsetsZero)
            rightSnapshot.dc_x = containerView.dc_width
            rightSnapshot.dc_y = toView.dc_y
            
            let fromViewSnapshot = fromView.snapshotViewAfterScreenUpdates(false)
            fromViewSnapshot.frame = fromView.frame
            fromViewSnapshot.backgroundColor = UIColor.whiteColor()
            

            fromView.removeFromSuperview()
            containerView.addSubview(fromViewSnapshot)
            containerView.addSubview(leftSnapshot)
            containerView.addSubview(rightSnapshot)
            
            UIView.animateWithDuration(animationDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: UIViewAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
                leftSnapshot.dc_x = 0
                rightSnapshot.dc_x = containerView.dc_width/2
                fromViewSnapshot.transform = CGAffineTransformMakeScale(0.8, 0.8)
                
            }, completion: { (finished) -> Void in
                blankView.removeFromSuperview()
                leftSnapshot.removeFromSuperview()
                rightSnapshot.removeFromSuperview()
                fromViewSnapshot.removeFromSuperview()
                transitionContext.completeTransition(true)
            })
            
        }
        
        
        
    }
    
    override public func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        
        var duration:NSTimeInterval = 0
        
        switch transitionType {
        case .Appear:
            duration = 0.4
        case .Dissappear:
            duration = 0.4
        }
        return duration
    }

}
