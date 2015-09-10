//
//  TPMainVC.swift
//  TimePrep
//
//  Created by Marko Strizic on 15/10/14.
//  Copyright (c) 2014 XEE Tech. All rights reserved.
//

import UIKit

extension UIViewController {
    
    var revealVC:DCRevealVC? {
        
        var parentVC:UIViewController? = self.parentViewController
        
        while (parentVC != nil) {
            if parentVC!.isKindOfClass(DCRevealVC.self) {
                return parentVC as? DCRevealVC
            }
            parentVC = parentVC?.parentViewController
        }
        return nil
    }
}


public class DCRevealVC: UIViewController, UIGestureRecognizerDelegate {
    
    var menuWidth:CGFloat {return UIDevice.currentDevice().dc_isIpad ? 120 : 160 }
    
    private(set) var panGestureRecognizer:UIPanGestureRecognizer!
    private lazy var overlayView:UIView = {
        let overlayView = UIView()
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector("concealMenuAnimated"))
        overlayView.addGestureRecognizer(tapGesture)
//        overlayView.userInteractionEnabled = false
//        overlayView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
        return overlayView
    }()
    
    private(set) var menuNavigationController       :UINavigationController!
    private(set) var contentNavigationController    :UINavigationController!
    
    var contentVC:UIViewController? {return contentNavigationController.topViewController}
    var menuVC:UIViewController?    {return menuNavigationController.topViewController}

    var showMenuEnabled:Bool {
        get{
            return panGestureRecognizer.enabled
        }
        set{
            panGestureRecognizer.enabled = newValue
        }
    }
    
//    var animationView:UIView {return ((self.menuVC as! UINavigationController).topViewController as! DCRevealVC).collectionView }
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        contentNavigationController = UINavigationController()
        menuNavigationController = UINavigationController()
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "panGestureRecognizeAction:")
        panGestureRecognizer.delegate = self

    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        dc_attachChildVC(menuNavigationController)
        dc_attachChildVC(contentNavigationController)
        
        contentNavigationController.view.frame = self.view.bounds
        
        self.view.addGestureRecognizer(panGestureRecognizer)
        
    }
    
    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.setNavigationBarHidden(true, animated: true)
        menuNavigationController.view.frame = CGRectMake(0, 0, menuWidth, self.view.frame.height)
    }
    
    func setContentVC(contentVC:UIViewController, animated:Bool) {
        
        if self.contentVC === contentVC {
            return
        }
        self.contentNavigationController.setViewControllers([contentVC], animated: false)
    }
    
    func setMenuVC(menuVC:UIViewController, animated:Bool) {
        
        if self.menuVC === menuVC {
            return
        }
        self.menuNavigationController.setViewControllers([menuVC], animated: animated)
    }
    
    
    func toggleMenuAnimated() {
        
        if contentNavigationController.view.dc_x > 0 {
            concealMenuAnimated()
        }else{
            revealMenuAnimated()
        }
    }
    
    func revealMenuAnimated() {
        
        overlayView.frame = contentNavigationController!.view.bounds
        contentNavigationController!.view.addSubview(overlayView)
        
//        let front = contentVC
//        let frame = overlayView.frame
        
        
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.contentNavigationController.view.dc_x = self.menuNavigationController.view.dc_xRight
        }) { (finished) -> Void in
        }
    }
    
    func concealMenuAnimated() {
        
        overlayView.removeFromSuperview()
        
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.contentNavigationController.view.dc_x = 0
        }) { (finished) -> Void in
        }
    }
    
    //MARK: PanGestureRecognizer
    
    private var initialPanLocation:CGPoint!
    private var initialFrontViewLocation:CGPoint!
    
    @objc private func panGestureRecognizeAction(sender:UIPanGestureRecognizer) {
        
        switch sender.state {
        case .Began:
            
            initialPanLocation = sender.locationInView(self.view)
            initialFrontViewLocation = contentNavigationController.view.frame.origin
            
        case .Changed:
            
            
            let currentTouchLocation = sender.locationInView(self.view)

            let differenceX = currentTouchLocation.x - initialPanLocation.x
            
            var newOrigin = initialFrontViewLocation
            newOrigin.x += differenceX
            
            if newOrigin.x <= 0 {
                newOrigin.x = 0
            }else if newOrigin.x >= menuWidth {
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
    
    public func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {

        if contentNavigationController.viewControllers.count > 1 {
            return false
        }
        
        let frontViewOrigin = contentNavigationController.view.frame.origin
        let location = gestureRecognizer.locationInView(self.contentNavigationController.view)
        if location.x < 50 || frontViewOrigin.x > 0{
            return true
        }
        return false
    }
    
    public func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailByGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
