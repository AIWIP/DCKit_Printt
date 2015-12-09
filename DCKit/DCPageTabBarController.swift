//
//  DCPageTabBarController.swift
//  DCKit
//
//  Created by Kristijan Delivuk on 12/1/15.
//  Copyright © 2015 Vladimir Kolbas. All rights reserved.
//

import UIKit
import SnapKit

// DCPageTabBarController needs to be modified with DCPageTabBarConfiguration

public struct DCPageTabBarConfiguration {
    var tabBarMenuBackgroundColor: UIColor = .whiteColor()
    var selectionViewBackgroundColor: UIColor = .blueColor()
    
    var tabBarMenuSelectedItemColor: UIColor = .blueColor()
    var tabBarMenuItemColor: UIColor = .whiteColor()
    var titleLabelFont: UIFont = UIFont(name: "Helvetica Neue", size: 13)!
}

public class DCPageTabBarController: UIViewController, DCPageTabBarContentScrollVCDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    static var configuration = DCPageTabBarConfiguration()
    
    private var contentVC:DCPageTabBarContentScrollVC!
    private var menuView:DCPageTabBarMenuView!
    
    
    private var viewControllers:[UIViewController]!
    public var currentViewController:UIViewController {return contentVC.currentViewController!}
    
    
    private(set) var menuViewSeparatorLine:UIView!
    
    public var startingIndex : Int = 0
    private var didLayoutOnce = false
    
    public func configure(viewControllers:[UIViewController]) {
        
        self.viewControllers = viewControllers
        if let contentVC = contentVC, let menuView = menuView  {
            contentVC.configure(self.viewControllers)
            menuView.reloadData()
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        contentVC = DCPageTabBarContentScrollVC()
        contentVC.delegate = self
        
        menuView = DCPageTabBarMenuView(startingIndex: startingIndex)
        menuView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        menuView.delegate = self
        menuView.dataSource = self
        menuView.registerClass(DCPageTabBarMenuItemView.self, forCellWithReuseIdentifier: DCPageTabBarMenuItemView.identifier)
        
        
        menuViewSeparatorLine = UIView()
        menuViewSeparatorLine.backgroundColor = UIColor.grayColor()
        
        
        
        dc_attachChildVC(contentVC)
        view.addSubview(menuView)
        view.addSubview(menuViewSeparatorLine)
        
        menuViewSeparatorLine.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(0)
            make.top.equalTo(menuView.snp_bottom)
            make.height.equalTo(1)
        }
        
        
        menuView.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(0)
            make.height.equalTo(44)
        }
        
        contentVC.view.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(menuView.snp_bottom)
            make.left.right.bottom.equalTo(0)
        }
        
    }
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !didLayoutOnce {
            didLayoutOnce = true
            contentVC.showViewControllerAtIndex(startingIndex, animated: false)
        }
    }
    
    override public func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let indexPath = NSIndexPath(forItem: startingIndex, inSection: 0)
        menuView.selectItemAtIndexPath(indexPath, animated: false, scrollPosition: .None)
    }
    
    public func pageTabBarContentScrollVC(vc: DCPageTabBarContentScrollVC, didChangeContentOffset offset: CGPoint) {
        
        let menuViewHorizontalSize = menuView.contentSize.width + menuView.contentInset.left + menuView.contentInset.right
        let viewWidth = view.frame.width
        
        let ratio = (menuViewHorizontalSize - viewWidth) / (vc.scrollView!.contentSize.width - viewWidth)
        
        if menuView.contentSize.width > view.frame.width {
            var menuOffset = menuView.contentOffset
            menuOffset.x = offset.x*ratio-menuView.contentInset.left
            menuView.setContentOffset(menuOffset, animated: false)
        }
    }
    
    public func pageTabBarContentScrollVC(vc: DCPageTabBarContentScrollVC, didTransitionToViewController currentVC: UIViewController) {
    }
    
    public func pageTabBarContentScrollVC(vc: DCPageTabBarContentScrollVC, willTransitionToViewController currentVC: UIViewController) {
        if let currentIndex = viewControllers.indexOf(currentVC) {
            menuView.selectItemAtIndexPath(NSIndexPath(forItem: currentIndex, inSection: 0), animated: true, scrollPosition: .None)
        }
    }
    
    //MARK: DCPageTabBarMenuView
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewControllers.count
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(DCPageTabBarMenuItemView.identifier, forIndexPath: indexPath) as! DCPageTabBarMenuItemView
        
        cell.titleLabel.text = viewControllers[indexPath.row].title?.uppercaseString
        
        return cell
    }
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return DCPageTabBarMenuItemView.sizeForText(viewControllers[indexPath.row].title ?? "--")
    }
    
    
    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.selectItemAtIndexPath(indexPath, animated: true, scrollPosition: .None)
        contentVC.showViewControllerAtIndex(indexPath.row)
    }
    
}


//***********************************************************

//MARK: - DCPageTabBarMenuView

private class DCPageTabBarMenuView: UICollectionView {
    
    private var selectionView = UIView()
    private var startingIndex : Int
    
    init(startingIndex: Int) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        self.startingIndex = startingIndex
        super.init(frame: CGRectZero, collectionViewLayout: layout)
        
        self.backgroundColor = DCPageTabBarController.configuration.tabBarMenuBackgroundColor
        
        
        selectionView.backgroundColor = DCPageTabBarController.configuration.selectionViewBackgroundColor
        selectionView.frame = CGRect(x: 0, y: 0, width: 100, height: 5)
        showsHorizontalScrollIndicator = false
        
        scrollsToTop = false
        
        addSubview(selectionView)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var didLayoutSubviews:Bool = false
    
    private override func layoutSubviews() {
        super.layoutSubviews()
        
        if didLayoutSubviews == false {
            didLayoutSubviews = true
            let indexPath = NSIndexPath(forItem: startingIndex, inSection: 0)
            scrollToItemAtIndexPath(indexPath, atScrollPosition: .None, animated: false)
            selectItemAtIndexPath(indexPath, animated: false, scrollPosition: .None)
        }
    }
    
    private override func selectItemAtIndexPath(indexPath: NSIndexPath?, animated: Bool, scrollPosition: UICollectionViewScrollPosition) {
        super.selectItemAtIndexPath(indexPath, animated: true, scrollPosition: .None)
        
        if let cell = cellForItemAtIndexPath(indexPath!) {
            
            let duration = animated ? 0.2 : 0.0
            
            UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: UIViewAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
                self.selectionView.dc_width = cell.dc_width
                self.selectionView.dc_centerX = cell.dc_centerX
                self.selectionView.dc_y = self.dc_height-self.selectionView.dc_height
                }, completion: nil)
        }
    }
    
}

private class DCPageTabBarMenuItemView: UICollectionViewCell {
    
    private(set) var titleLabel:UILabel!
    
    override var selected: Bool {
        didSet{
            if selected {
                titleLabel.textColor = DCPageTabBarController.configuration.tabBarMenuSelectedItemColor
            }else {
                titleLabel.textColor = DCPageTabBarController.configuration.tabBarMenuItemColor
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel = UILabel()
        titleLabel.font = DCPageTabBarController.configuration.titleLabelFont
        titleLabel.textAlignment = .Center
        contentView.addSubview(titleLabel)
        
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.top.leading.equalTo(5)
            make.bottom.trailing.equalTo(-5)
        }
        
        prepareForReuse()
    }
    
    private override func prepareForReuse() {
        super.prepareForReuse()
        selected = false
        titleLabel.text = nil
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    class var identifier:String {
        return NSStringFromClass(self)
    }
    
    class func sizeForText(text:String) -> CGSize {
        
        var rect = CGRect()
        // TODO: fix
        rect = text.boundingRectWithSize(CGSize(), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont(name: "Helvetica Neue", size: 12)!], context: nil)
        return CGSize(width: rect.width+55, height: 30)
    }
    
}

//***********************************************************

//MARK: - DCPageTabBarContentScrollVC


public protocol DCPageTabBarContentScrollVCDelegate : class {
    
    func pageTabBarContentScrollVC(vc:DCPageTabBarContentScrollVC, didChangeContentOffset offset:CGPoint)
    func pageTabBarContentScrollVC(vc:DCPageTabBarContentScrollVC, didTransitionToViewController currentVC:UIViewController)
    func pageTabBarContentScrollVC(vc:DCPageTabBarContentScrollVC, willTransitionToViewController currentVC:UIViewController)
    
    
}


public class DCPageTabBarContentScrollVC:UIViewController, UIScrollViewDelegate {
    
    private var viewControllers:[UIViewController] = []
    
    var scrollView:UIScrollView? {return view as? UIScrollView}
    private(set) var currentViewController:UIViewController?
    
    
    
    weak var delegate:DCPageTabBarContentScrollVCDelegate?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override public func loadView() {
        view = UIScrollView()
        scrollView!.delegate = self
        scrollView!.pagingEnabled = true
        scrollView!.scrollsToTop = false
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clearColor()
        
    }
    
    func configure(viewControllers:[UIViewController]) {
        
        self.viewControllers = []
        viewControllers.map({self.addViewController($0)})
        
        viewControllers.last?.view.snp_makeConstraints(closure:{ (make) -> Void in
            make.right.equalTo(0)
        })
        
        currentViewController = viewControllers.first
        
    }
    
    func showViewControllerAtIndex(index:Int, animated: Bool = true) {
        if index < viewControllers.count {
            let duration = animated ? 0.4 : 0.0
            UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 6.0, options: UIViewAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
                self.scrollView!.contentOffset = CGPoint(x: CGFloat(index)*self.view.frame.width, y: 0)
                }, completion: nil)
        }
    }
    
    
    private func addViewController(vc:UIViewController) {
        
        dc_attachChildVC(vc)
        
        vc.view.snp_makeConstraints { (make) -> Void in
            if self.viewControllers.count == 0 {
                make.left.equalTo(0)
            }else{
                make.left.equalTo(self.viewControllers.last!.view.snp_right)
            }
            make.top.equalTo(0)
            make.height.equalTo(view!.snp_height)
            make.width.equalTo(view!.snp_width)
        }
        
        self.viewControllers.append(vc)
    }
    
    
    //MARK: UIScrollView
    
    private var newCurrentIndex:Int?
    
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        delegate?.pageTabBarContentScrollVC(self, didChangeContentOffset: scrollView.contentOffset)
        
        
        let newIndex = round(scrollView.contentOffset.x/view.frame.width)
        if newCurrentIndex != Int(newIndex) {
            newCurrentIndex = Int(newIndex)
            delegate?.pageTabBarContentScrollVC(self, willTransitionToViewController: viewControllers[newCurrentIndex!])
        }
        
    }
    
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let currentOffset = scrollView.contentOffset
        
        if let currentVC = viewControllers.filter({$0.view.frame.origin.x == currentOffset.x}).first {
            currentViewController = currentVC
            delegate?.pageTabBarContentScrollVC(self, didTransitionToViewController: currentViewController!)
        }
    }
}