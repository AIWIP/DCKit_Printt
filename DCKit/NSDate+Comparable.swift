//
//  NSDate+Comparable.swift
//  DCKit
//
//  Created by Vladimir Kolbas on 10/30/15.
//  Copyright © 2015 Vladimir Kolbas. All rights reserved.
//

import Foundation

// MARK: - NSDate conformance to Comparable protocol

extension NSDate: Comparable {
    /// Implementation of comparable protocol for NSDate
}

public func < (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs as Date) == .orderedAscending
}

public func == (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs as Date) == .orderedSame
}
