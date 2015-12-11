//
//  SampleVC.swift
//  DCKit
//
//  Created by Kristijan Delivuk on 12/11/15.
//  Copyright © 2015 Vladimir Kolbas. All rights reserved.
//

import UIKit

class SampleVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.dc_randomColor()
        
        title = "Title"
    }
}

extension UIColor {
    static func dc_randomColor() -> UIColor {
        let red = CGFloat.random()
        let green = CGFloat.random()
        let blue = CGFloat.random()
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}