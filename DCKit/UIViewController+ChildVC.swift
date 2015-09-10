//
//  UIViewController+ChildVC.swift
//  DCKit
//
//  Created by Marko Strizic on 13/05/15.
//  Copyright (c) 2015 DeCode. All rights reserved.
//

import UIKit


public extension UIViewController {
    
    public func dc_attachChildVC(childVC:UIViewController) {
        dc_attachChildVC(childVC, parentView: self.view)
    }
    
    public func dc_attachChildVC(childVC:UIViewController, parentView:UIView) {
        
        addChildViewController(childVC)
        parentView.addSubview(childVC.view)
        childVC.didMoveToParentViewController(self)
    }
    
    public func dc_attachChildVCWithoutAddingToViewHierarchy(childVC:UIViewController) {
        addChildViewController(childVC)
        childVC.didMoveToParentViewController(self)
    }
    
    public func dc_detachVCFromParentVC() {
    
        view.removeFromSuperview()
        removeFromParentViewController()
        didMoveToParentViewController(nil)
        
        
    }
    
    
    
    public func dc_transitionWithSpring(fromVC fromVC:UIViewController, toVC:UIViewController, animationDuration:Double, springValue:Double, velocity:Double, prepareLayoutBlock:(()->Void)?, animationBlock:(fromViewSnaphot:UIView, toView:UIView)->Void, completionBlock:((Bool)->Void)?) {
        
        let fromViewSnaphot = fromVC.view.snapshotViewAfterScreenUpdates(false)
        fromViewSnaphot.frame = fromVC.view.frame
        view.addSubview(fromViewSnaphot)
        
        fromVC.beginAppearanceTransition(false, animated: true)
        fromVC.view.removeFromSuperview()

        let toView = toVC.view
        view.addSubview(toView)
        
        prepareLayoutBlock?()
        
        UIView.animateWithDuration(animationDuration, delay: 0, usingSpringWithDamping: CGFloat(springValue), initialSpringVelocity: CGFloat(velocity), options: UIViewAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
            animationBlock(fromViewSnaphot: fromViewSnaphot, toView: toView)
        }) { (finished) -> Void in
            fromVC.endAppearanceTransition()
            fromViewSnaphot.removeFromSuperview()
            completionBlock?(finished)
        }
        

    }
    
    
    
}