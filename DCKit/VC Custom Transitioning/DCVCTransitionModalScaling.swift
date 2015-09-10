//
//  XEEModalAnimation.swift
//  TimePrep
//
//  Created by Marko Strizic on 21/10/14.
//  Copyright (c) 2014 XEE Tech. All rights reserved.
//


public class DCVCTransitionModalScaling: DCVCTransitionBase {
    
    public var scalingToViewVCEnabled               = true
    public var springDamping:CGFloat                = 0.9
    public var springVelocity:CGFloat               = 5
    public var durationAppearing:NSTimeInterval     = 0.4
    public var durationDissappearing:NSTimeInterval = 0.4

    
    
    override public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        guard let containerView = transitionContext.containerView()else {
            fatalError("Containerview should be present")
        }
        
        let fromViewVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let fromView = fromViewVC.view
        
        let toViewVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let toView = toViewVC.view
        toView.translatesAutoresizingMaskIntoConstraints = true
        
        let toViewFinalFrame = transitionContext.finalFrameForViewController(toViewVC)
        
        let animationDuration = self.transitionDuration(transitionContext)
        
        
        containerView.insertSubview(toView, belowSubview: fromView)
        
        let fromViewSnapshot = fromView.snapshotViewAfterScreenUpdates(false)
        fromViewSnapshot.frame = fromView.frame
        let toViewSnapshot = toView
//        toView.frame.offset(dx: 0, dy: containerView.height)
        fromView.removeFromSuperview()

        if self.transitionType == .Appear {
            
            containerView.addSubview(fromViewSnapshot)
            containerView.addSubview(toViewSnapshot)

            
            toViewSnapshot.frame.offsetInPlace(dx: 0, dy: containerView.frame.height)
            
            UIView.animateWithDuration(animationDuration, delay: 0, usingSpringWithDamping: springDamping, initialSpringVelocity: springVelocity, options: UIViewAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
                
                toViewSnapshot.frame = toViewFinalFrame
                fromViewSnapshot.alpha = 0
                
            },completion: { (finished) -> Void in
                fromViewSnapshot.removeFromSuperview()
                toView.frame = toViewFinalFrame
//                toViewSnapshot.removeFromSuperview()
                transitionContext.completeTransition(true)
            })
        }else if transitionType == .Dissappear {
            
            containerView.addSubview(toViewSnapshot)
            containerView.addSubview(fromViewSnapshot)

            
            toViewSnapshot.frame = toViewFinalFrame
            toViewSnapshot.alpha = 0
            if scalingToViewVCEnabled {
                toViewSnapshot.transform = CGAffineTransformMakeScale(0.9, 0.9)
            }
            
            UIView.animateWithDuration(animationDuration, delay: 0, usingSpringWithDamping: springDamping, initialSpringVelocity: springVelocity, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                
                fromViewSnapshot.frame.offsetInPlace(dx: 0, dy: containerView.frame.height)
                toViewSnapshot.alpha = 1
                toViewSnapshot.transform = CGAffineTransformIdentity
                
            }, completion: { (finished) -> Void in
                fromViewSnapshot.removeFromSuperview()
                toView.frame = toViewFinalFrame
//                toViewSnapshot.removeFromSuperview()
                transitionContext.completeTransition(true)
            })
        }
        
    }
    
    override public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        
        var duration:NSTimeInterval = 0
        
        switch transitionType{
        case .Appear:
            duration = durationAppearing
        case .Dissappear:
            duration = durationDissappearing
        }
        return duration
    }


}
