//
//  UICollectionViewCell+ReuseIdentifier.swift
//  DCKit
//
//  Created by Vladimir Kolbas on 9/1/15.
//  Copyright (c) 2015 Vladimir Kolbas. All rights reserved.
//

import UIKit

public extension UICollectionViewCell {
    
    public class var dc_reuseClassIdentifier:String { return NSStringFromClass(self) }

}