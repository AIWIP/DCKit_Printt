//
//  Array+XEE.swift
//  TimePrep
//
//  Created by Marko Strizic on 16/12/14.
//  Copyright (c) 2014 XEE Tech. All rights reserved.
//

import Foundation

public extension RangeReplaceableCollectionType where Generator.Element : Equatable  {
    
    public mutating func dc_contains<T where T : Equatable>(obj: T) -> Bool {
        return self.filter({$0 as? T == obj}).count > 0
    }
    
    public mutating func dc_removeObject(obj: Generator.Element) -> Bool {
        
        if let indexToRemove = self.indexOf(obj) {
            removeAtIndex(indexToRemove)
            return true
        }
        return false
    }

}