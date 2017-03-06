//
//  DCModalSimpleAnimation.swift
//  CroTourism
//
//  Created by Marko Strizic on 09/06/15.
//  Copyright (c) 2015 DeCode. All rights reserved.
//

import UIKit

open class DCVCTransitionModal: DCVCTransitionBase {
   
    open var springDamping:CGFloat                = 1
    open var springVelocity:CGFloat               = 5
    open var durationAppearing:TimeInterval     = 1
    open var durationDissappearing:TimeInterval = 1

    
    override open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        let fromViewVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let fromView = fromViewVC.view!
        
        let toViewVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let toView = toViewVC.view!
        
        toView.translatesAutoresizingMaskIntoConstraints = true
        
        let toViewFinalFrame = transitionContext.finalFrame(for: toViewVC)
        
        let animationDuration = self.transitionDuration(using: transitionContext)
        
        let fromViewSnapshot = fromView.snapshotView(afterScreenUpdates: false)!
        fromViewSnapshot.frame = (fromView.frame)
//        fromView.removeFromSuperview()
        
        if transitionType == .appear {
            
            containerView.addSubview(fromViewSnapshot)
            containerView.addSubview(toView)
            
            toView.frame = toView.frame.offsetBy(dx: 0, dy: containerView.frame.height)
            
            UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: springDamping, initialSpringVelocity: springVelocity, options: UIViewAnimationOptions.beginFromCurrentState, animations: { () -> Void in
                
                toView.frame = toViewFinalFrame
                
            },completion: { (finished) -> Void in
                fromViewSnapshot.removeFromSuperview()
                transitionContext.completeTransition(true)
            })
        }else if transitionType == .dissappear {
            
            containerView.addSubview(toView)
            containerView.addSubview(fromViewSnapshot)
            
            toView.frame = toViewFinalFrame
            
            let finalAnimationFrame = fromViewSnapshot.frame.offsetBy(dx: 0, dy: containerView.frame.height)
            
            UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: springDamping, initialSpringVelocity: springVelocity, options: UIViewAnimationOptions.beginFromCurrentState, animations: { () -> Void in
                
                fromViewSnapshot.frame = finalAnimationFrame
                
            }, completion: { (finished) -> Void in
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
