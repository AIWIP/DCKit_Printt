//
//  NSURLResponse+DebugPrint.swift
//  DCKit
//
//  Created by Marko Strizic on 10/09/15.
//  Copyright (c) 2015 DECODE. All rights reserved.
//

import Foundation


public extension NSHTTPURLResponse {
    
    public func dc_debugDescription(showHeader showHeader:Bool, body:NSData?) -> String {
        
        
        let urlInfo = "URL: (\(statusCode)) " + URL!.absoluteString + "\n"
        
        var info = "\n\n****** URL RESPONSE ********\n" + urlInfo
        
        if showHeader == true {
            let header = "Headers:\n" + allHeaderFields.debugDescription
            info = info + header + "\n"
        }
        
        if let body = body {
            let bodyString = NSString(data: body, encoding: NSUTF8StringEncoding) as! String
            let bodyInfo = "Body:\n" + bodyString
            info = info + bodyInfo
        }
        
        info = info + "\n\n"
        
        return info
    }
}