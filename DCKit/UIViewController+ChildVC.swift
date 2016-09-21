//
//  UIViewController+ChildVC.swift
//  DCKit
//
//  Created by Marko Strizic on 13/05/15.
//  Copyright (c) 2015 DeCode. All rights reserved.
//

import UIKit


public extension UIViewController {
    
    public func dc_attachChildVC(_ childVC:UIViewController) {
        dc_attachChildVC(childVC, parentView: self.view)
    }
    
    public func dc_attachChildVC(_ childVC:UIViewController, parentView:UIView) {
        
        addChildViewController(childVC)
        parentView.addSubview(childVC.view)
        childVC.didMove(toParentViewController: self)
    }
    
    public func dc_attachChildVCWithoutAddingToViewHierarchy(_ childVC:UIViewController) {
        addChildViewController(childVC)
        childVC.didMove(toParentViewController: self)
    }
    
    public func dc_detachVCFromParentVC() {
    
        view.removeFromSuperview()
        removeFromParentViewController()
        didMove(toParentViewController: nil)
        
        
    }
    
    
    
    public func dc_transitionWithSpring(fromVC:UIViewController, toVC:UIViewController, animationDuration:Double, springValue:Double, velocity:Double, prepareLayoutBlock:(()->Void)?, animationBlock:@escaping (_ fromViewSnaphot:UIView, _ toView:UIView)->Void, completionBlock:((Bool)->Void)?) {
        
        let fromViewSnaphot = fromVC.view.snapshotView(afterScreenUpdates: false)
        fromViewSnaphot?.frame = fromVC.view.frame
        view.addSubview(fromViewSnaphot!)
        
        fromVC.beginAppearanceTransition(false, animated: true)
        fromVC.view.removeFromSuperview()

        let toView = toVC.view
        view.addSubview(toView!)
        
        prepareLayoutBlock?()
        
        UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: CGFloat(springValue), initialSpringVelocity: CGFloat(velocity), options: UIViewAnimationOptions.beginFromCurrentState, animations: { () -> Void in
            animationBlock(fromViewSnaphot!, toView!)
        }) { (finished) -> Void in
            fromVC.endAppearanceTransition()
            fromViewSnaphot?.removeFromSuperview()
            completionBlock?(finished)
        }
        

    }
    
    
    
}
