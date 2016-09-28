//
//  XEEModalAnimation.swift
//  TimePrep
//
//  Created by Marko Strizic on 21/10/14.
//  Copyright (c) 2014 XEE Tech. All rights reserved.
//


open class DCVCTransitionModalScaling: DCVCTransitionBase {
    
    open var scalingToViewVCEnabled               = true
    open var springDamping:CGFloat                = 0.9
    open var springVelocity:CGFloat               = 5
    open var durationAppearing:TimeInterval     = 0.4
    open var durationDissappearing:TimeInterval = 0.4

    
    
    override open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        let fromViewVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let fromView = fromViewVC.view!
        
        let toViewVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let toView = toViewVC.view!
        toView.translatesAutoresizingMaskIntoConstraints = true
        
        let toViewFinalFrame = transitionContext.finalFrame(for: toViewVC)
        
        let animationDuration = self.transitionDuration(using: transitionContext)
        
        
        containerView.insertSubview(toView, belowSubview: fromView)
        
        let fromViewSnapshot = fromView.snapshotView(afterScreenUpdates: false)!
        fromViewSnapshot.frame = (fromView.frame)
        let toViewSnapshot = toView
//        toView.frame.offset(dx: 0, dy: containerView.height)
        fromView.removeFromSuperview()

        if self.transitionType == .appear {
            
            containerView.addSubview(fromViewSnapshot)
            containerView.addSubview(toViewSnapshot)

            toViewSnapshot.frame = toViewSnapshot.frame.offsetBy(dx: 0, dy: containerView.frame.height)
            
            UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: springDamping, initialSpringVelocity: springVelocity, options: UIViewAnimationOptions.beginFromCurrentState, animations: { () -> Void in
                
                toViewSnapshot.frame = toViewFinalFrame
                fromViewSnapshot.alpha = 0
                
            },completion: { (finished) -> Void in
                fromViewSnapshot.removeFromSuperview()
                toView.frame = toViewFinalFrame
//                toViewSnapshot.removeFromSuperview()
                transitionContext.completeTransition(true)
            })
        }else if transitionType == .dissappear {
            
            containerView.addSubview(toViewSnapshot)
            containerView.addSubview(fromViewSnapshot)

            
            toViewSnapshot.frame = toViewFinalFrame
            toViewSnapshot.alpha = 0
            if scalingToViewVCEnabled {
                toViewSnapshot.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }
            
            UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: springDamping, initialSpringVelocity: springVelocity, options: UIViewAnimationOptions.curveEaseOut, animations: { () -> Void in
                
                fromViewSnapshot.frame = fromViewSnapshot.frame.offsetBy(dx: 0, dy: containerView.frame.height)
                toViewSnapshot.alpha = 1
                toViewSnapshot.transform = CGAffineTransform.identity
                
            }, completion: { (finished) -> Void in
                fromViewSnapshot.removeFromSuperview()
                toView.frame = toViewFinalFrame
//                toViewSnapshot.removeFromSuperview()
                transitionContext.completeTransition(true)
            })
        }
        
    }
    
    override open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        var duration:TimeInterval = 0
        
        switch transitionType{
        case .appear:
            duration = durationAppearing
        case .dissappear:
            duration = durationDissappearing
        }
        return duration
    }


}
