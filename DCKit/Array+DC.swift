//
//  Array+XEE.swift
//  TimePrep
//
//  Created by Marko Strizic on 16/12/14.
//  Copyright (c) 2014 XEE Tech. All rights reserved.
//

import Foundation

extension Array {
    
    mutating func dc_contains<T where T : Equatable>(obj: T) -> Bool {
        return self.filter({$0 as? T == obj}).count > 0
    }
    
    mutating func dc_removeObject<T where T : Equatable>(obj: T) -> Bool {
        
        
        var indexToRemove:Int?
        for (index,eachElement) in enumerate(self) {
            if eachElement as! T == obj {
                indexToRemove = index
            }
        }
        if indexToRemove != nil {
            removeAtIndex(indexToRemove!)
            return true
        }
        return false
    }
    
    
    func dc_find (includedElement: T -> Bool) -> Int? {
        for (idx, element) in enumerate(self) {
            if includedElement(element) {
                return idx
            }
        }
        return nil
    }
    

}