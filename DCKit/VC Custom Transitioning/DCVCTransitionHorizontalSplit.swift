//
//  XEEHorizontalSplitAnimation.swift
//  TimePrep
//
//  Created by Marko Strizic on 25/11/14.
//  Copyright (c) 2014 XEE Tech. All rights reserved.
//

import UIKit

open class DCVCTransitionHorizontalSplit: DCVCTransitionBase {
    
    open var springDamping:CGFloat                = 1
    open var springVelocity:CGFloat               = 5
    open var durationAppearing:TimeInterval     = 0.4
    open var durationDissappearing:TimeInterval = 0.4

    override open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        let fromViewVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        
        let toView = toViewVC.view!
        
        let fromView = fromViewVC.view!
        fromView.translatesAutoresizingMaskIntoConstraints = true

        
//        let toViewFinalFrame = transitionContext.finalFrameForViewController(toViewVC)
        
        
        let animationDuration = self.transitionDuration(using: transitionContext)
        
        if transitionType == .appear {
            
            var snapshotFrame = CGRect(x: 0, y: 0, width: (fromView.frame.width)/2, height: (fromView.frame.height))
            
            
            let leftSnapshot = fromView.resizableSnapshotView(from: snapshotFrame, afterScreenUpdates: false, withCapInsets: UIEdgeInsets.zero)!
            leftSnapshot.dc_x = 0
            leftSnapshot.dc_y = (fromView.dc_y)

            
            snapshotFrame.origin.x = (fromView.dc_width)/2
            
            let rightSnapshot = fromView.resizableSnapshotView(from: snapshotFrame, afterScreenUpdates: false, withCapInsets: UIEdgeInsets.zero)!
            rightSnapshot.dc_x = (fromView.dc_width)/2
            rightSnapshot.dc_y = (fromView.dc_y)
            
            toView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            
            fromView.removeFromSuperview()
            containerView.addSubview(toView)
            containerView.addSubview(leftSnapshot)
            containerView.addSubview(rightSnapshot)
            
            UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: springDamping, initialSpringVelocity: springVelocity, options: UIViewAnimationOptions.beginFromCurrentState, animations: { () -> Void in
                leftSnapshot.dc_x -= leftSnapshot.dc_width
                rightSnapshot.dc_x += rightSnapshot.dc_width
                toView.transform = CGAffineTransform.identity

            }, completion: { (finished) -> Void in
                leftSnapshot.removeFromSuperview()
                rightSnapshot.removeFromSuperview()
                transitionContext.completeTransition(true)
            })
            
        }else if transitionType == .dissappear {
            
            containerView.addSubview(toView)
            
            
            let blankView = UIView()
            blankView.backgroundColor = UIColor.white
            blankView.frame = containerView.bounds
            containerView.addSubview(blankView)
            
            var snapshotFrame = CGRect(x: 0, y: 0, width: (fromView.frame.width)/2, height: (fromView.frame.height))
            
            let leftSnapshot = toView.resizableSnapshotView(from: snapshotFrame, afterScreenUpdates: true, withCapInsets: UIEdgeInsets.zero)!
            leftSnapshot.dc_x = -(leftSnapshot.dc_width)
            leftSnapshot.dc_y = (toView.dc_y)
            
            
            snapshotFrame.origin.x = (fromView.frame.width)/2
            let rightSnapshot = toView.resizableSnapshotView(from: snapshotFrame, afterScreenUpdates: true, withCapInsets: UIEdgeInsets.zero)!
            rightSnapshot.dc_x = containerView.dc_width
            rightSnapshot.dc_y = (toView.dc_y)
            
            let fromViewSnapshot = fromView.snapshotView(afterScreenUpdates: false)!
            fromViewSnapshot.frame = (fromView.frame)
            fromViewSnapshot.backgroundColor = UIColor.white
            

            fromView.removeFromSuperview()
            containerView.addSubview(fromViewSnapshot)
            containerView.addSubview(leftSnapshot)
            containerView.addSubview(rightSnapshot)
            
            UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: springDamping, initialSpringVelocity: springVelocity, options: UIViewAnimationOptions.beginFromCurrentState, animations: { () -> Void in
                leftSnapshot.dc_x = 0
                rightSnapshot.dc_x = containerView.dc_width/2
                fromViewSnapshot.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                
            }, completion: { (finished) -> Void in
                blankView.removeFromSuperview()
                leftSnapshot.removeFromSuperview()
                rightSnapshot.removeFromSuperview()
                fromViewSnapshot.removeFromSuperview()
                transitionContext.completeTransition(true)
            })
            
        }
        
        
        
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
