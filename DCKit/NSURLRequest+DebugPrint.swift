//
//  NSURLRequest+DebugPrint.swift
//  DCKit
//
//  Created by Marko Strizic on 09/09/15.
//  Copyright (c) 2015 DECODE. All rights reserved.
//

import Foundation

public extension NSURLRequest {
    
    public func dc_debugDescription(showHeader showHeader:Bool, showBody:Bool) -> String {
        
        
        let urlInfo = "URL: (" + HTTPMethod! + ") " + URL!.absoluteString + "\n"
        
        var info = "\n\n****** URL REQUEST ********\n" + urlInfo
        
        if let headerFields = allHTTPHeaderFields?.description where showHeader == true {
            let header = "Headers:\n" + headerFields
            info = info + header + "\n"
        }
        
        
        
        if let body = HTTPBody where showBody == true{
            let bodyString = NSString(data: body, encoding: NSUTF8StringEncoding) as! String
            let bodyInfo = "Body:\n" + bodyString
            info = info + bodyInfo
        }
        
        info = info + "\n\n"
        
        return info
    }
}