//
//  DCMenuPageVC.swift
//  DCKit
//
//  Created by Kristijan Delivuk on 12/11/15.
//  Copyright © 2015 Vladimir Kolbas. All rights reserved.
//

import DCKit

class DCMenuPageVC: DCPageTabBarController {

    private var _controllers : [UIViewController] = []
    
    convenience init(viewControllers: [UIViewController]) {
        self.init(nibName: nil, bundle: nil)
        
        _controllers = viewControllers
        startingIndex = 0
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(_controllers)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        _controllers.map({self.turnOffScrollToTopRecursive($0.view)})
        if let scrollView = findFirstScrollView(currentViewController.view) {
            scrollView.scrollsToTop = true
        }
        
    }
    
    override func pageTabBarContentScrollVC(vc: DCPageTabBarContentScrollVC, didTransitionToViewController currentVC: UIViewController) {
        super.pageTabBarContentScrollVC(vc, didTransitionToViewController: currentVC)
        
        _controllers.map({self.turnOffScrollToTopRecursive($0.view)})
        
        if let scrollView = findFirstScrollView(currentVC.view) {
            scrollView.scrollsToTop = true
        }
        
        
    }
    
    private func turnOffScrollToTopRecursive(view:UIView) {
        
        if let scrollView = view as? UIScrollView {
            scrollView.scrollsToTop = false
        }
        
        for eachSubview in view.subviews {
            turnOffScrollToTopRecursive(eachSubview)
        }
    }
    
    private func findFirstScrollView(view:UIView) -> UIScrollView? {
        
        if let scrollView = view as? UIScrollView {
            return scrollView
        }
        
        if view.subviews.count > 0 {
            for eachSubview in view.subviews {
                return findFirstScrollView(eachSubview)
            }
        }
        
        return nil
        
    }
}
