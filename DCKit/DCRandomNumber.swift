//
//  DECODE+RandomNumber.swift
//  CroTourism
//
//  Created by Marko Strizic on 03/07/15.
//  Copyright (c) 2015 DeCode. All rights reserved.
//

import Foundation


public extension Int {
    /**
    Returns a random integer between 0 and n-1.
    */
    public static func random(_ n: Int) -> Int {
        return Int(arc4random_uniform(UInt32(n)))
    }
    /**
    Create a random num Int
    - parameter lower: number Int
    - parameter upper: number Int
    :return: random number Int
    By DaRkDOG
    */
    public static func random(min: Int, max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max - min + 1))) + min
    }
}

public extension Double {
    /**
    Returns a random floating point number between 0.0 and 1.0, inclusive.
    By DaRkDOG
    */
    public static func random() -> Double {
        return Double(arc4random()) / 0xFFFFFFFF
    }
    
    /**
    Create a random num Double
    - parameter lower: number Double
    - parameter upper: number Double
    :return: random number Double
    By DaRkDOG
    */
    public static func random(min: Double, max: Double) -> Double {
        return Double.random() * (max - min) + min
    }
}

public extension Float {
    /**
    Returns a random floating point number between 0.0 and 1.0, inclusive.
    By DaRkDOG
    */
    public static func random() -> Float {
        return Float(arc4random()) / 0xFFFFFFFF
    }
    /**
    Create a random num Float
    - parameter lower: number Float
    - parameter upper: number Float
    :return: random number Float
    By DaRkDOG
    */
    public static func random(min: Float, max: Float) -> Float {
        return Float.random() * (max - min) + min
    }
}

public extension CGFloat {
    /**
    Returns a random floating point number between 0.0 and 1.0, inclusive.
    By DaRkDOG
    */
    public static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    /**
    Create a random num CGFloat
    - parameter lower: number CGFloat
    - parameter upper: number CGFloat
    :return: random number CGFloat
    By DaRkDOG
    */
    public static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat.random() * (max - min) + min
    }
}
