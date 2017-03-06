//
//  TPMainVC.swift
//  TimePrep
//
//  Created by Marko Strizic on 15/10/14.
//  Copyright (c) 2014 XEE Tech. All rights reserved.
//

import UIKit

extension UIViewController {
    
    public var dc_revealVC:DCRevealVC? {
        
        var parentVC:UIViewController? = self.parent
        
        while (parentVC != nil) {
            if parentVC!.isKind(of: DCRevealVC.self) {
                return parentVC as? DCRevealVC
            }
            parentVC = parentVC?.parent
        }
        return nil
    }
}


open class DCRevealVC: UIViewController, UIGestureRecognizerDelegate {
    
    open var menuWidth:CGFloat {return UIDevice.current.dc_isIpad ? 120 : 160 }
    
    open var panGestureRecognizer:UIPanGestureRecognizer!
    fileprivate lazy var overlayView:UIView = {
        let overlayView = UIView()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(DCRevealVC.concealMenuAnimated))
        overlayView.addGestureRecognizer(tapGesture)
        //        overlayView.userInteractionEnabled = false
        //        overlayView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
        return overlayView
    }()
    
    open var menuNavigationController       :UINavigationController!
    open var contentNavigationController    :UINavigationController!
    
    open var contentVC:UIViewController? {return contentNavigationController.topViewController}
    open var menuVC:UIViewController?    {return menuNavigationController.topViewController}
    
    open var showMenuEnabled:Bool {
        get{
            return panGestureRecognizer.isEnabled
        }
        set{
            panGestureRecognizer.isEnabled = newValue
        }
    }
    
    //    var animationView:UIView {return ((self.menuVC as! UINavigationController).topViewController as! DCRevealVC).collectionView }
    
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        
        contentNavigationController = UINavigationController()
        menuNavigationController = UINavigationController()
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(DCRevealVC.panGestureRecognizeAction(_:)))
        panGestureRecognizer.delegate = self
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        dc_attachChildVC(menuNavigationController)
        dc_attachChildVC(contentNavigationController)
        
        contentNavigationController.view.frame = self.view.bounds
        
        self.view.addGestureRecognizer(panGestureRecognizer)
        
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.setNavigationBarHidden(true, animated: true)
        menuNavigationController.view.frame = CGRect(x: 0, y: 0, width: menuWidth, height: self.view.frame.height)
    }
    
    open func setContentVC(_ contentVC:UIViewController, animated:Bool) {
        
        if self.contentVC === contentVC {
            return
        }
        self.contentNavigationController.setViewControllers([contentVC], animated: false)
    }
    
    open func setMenuVC(_ menuVC:UIViewController, animated:Bool) {
        
        if self.menuVC === menuVC {
            return
        }
        self.menuNavigationController.setViewControllers([menuVC], animated: animated)
    }
    
    
    open func toggleMenuAnimated() {
        
        if contentNavigationController.view.dc_x > 0 {
            concealMenuAnimated()
        }else{
            revealMenuAnimated()
        }
    }
    
    open func revealMenuAnimated() {
        
        overlayView.frame = contentNavigationController!.view.bounds
        contentNavigationController!.view.addSubview(overlayView)
        
        //        let front = contentVC
        //        let frame = overlayView.frame
        
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
            self.contentNavigationController.view.dc_x = self.menuNavigationController.view.dc_xRight
            }) { (finished) -> Void in
        }
    }
    
    open func concealMenuAnimated() {
        
        overlayView.removeFromSuperview()
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
            self.contentNavigationController.view.dc_x = 0
            }) { (finished) -> Void in
        }
    }
    
    //MARK: PanGestureRecognizer
    
    fileprivate var initialPanLocation:CGPoint!
    fileprivate var initialFrontViewLocation:CGPoint!
    
    @objc fileprivate func panGestureRecognizeAction(_ sender:UIPanGestureRecognizer) {
        
        switch sender.state {
        case .began:
            
            initialPanLocation = sender.location(in: self.view)
            initialFrontViewLocation = contentNavigationController.view.frame.origin
            
        case .changed:
            
            
            let currentTouchLocation = sender.location(in: self.view)
            
            let differenceX = currentTouchLocation.x - initialPanLocation.x
            
            var newOrigin = initialFrontViewLocation!
            newOrigin.x += differenceX
            
            if newOrigin.x <= CGFloat(0.0) {
                newOrigin.x = 0
            }else if (newOrigin.x) >= menuWidth {
                newOrigin.x = menuWidth
            }
            
            contentNavigationController.view.frame.origin = newOrigin
            
            //            animationView.alpha = frontNavigationController.view.x/menuWidth
            
        default:()
        
        let frontViewOrigin = contentNavigationController.view.frame.origin
        
        if frontViewOrigin.x >= menuWidth/2 {
            revealMenuAnimated()
        }else{
            concealMenuAnimated()
            }
            
        }
        
    }
    
    open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if contentNavigationController.viewControllers.count > 1 {
            return false
        }
        
        let frontViewOrigin = contentNavigationController.view.frame.origin
        let location = gestureRecognizer.location(in: self.contentNavigationController.view)
        if location.x < 50 || frontViewOrigin.x > 0{
            return true
        }
        return false
    }
    
    open func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
