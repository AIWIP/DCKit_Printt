//
//  Array+XEE.swift
//  TimePrep
//
//  Created by Marko Strizic on 16/12/14.
//  Copyright (c) 2014 XEE Tech. All rights reserved.
//

import Foundation

public extension RangeReplaceableCollection where Iterator.Element : Equatable  {
    
    public mutating func dc_contains<T>(_ obj: T) -> Bool where T : Equatable {
        return self.filter({$0 as? T == obj}).count > 0
    }
    
    public mutating func dc_removeObject(_ obj: Iterator.Element) -> Bool {
        
        if let indexToRemove = self.index(of: obj) {
            remove(at: indexToRemove)
            return true
        }
        return false
    }

}
