//
//  NSURLResponse+DebugPrint.swift
//  DCKit
//
//  Created by Marko Strizic on 10/09/15.
//  Copyright (c) 2015 DECODE. All rights reserved.
//

import Foundation


public extension HTTPURLResponse {
    
    public func dc_debugDescription(showHeader:Bool, body:Data?) -> String {
        
        
        let urlInfo = "URL: (\(statusCode)) " + url!.absoluteString + "\n"
        
        var info = "\n\n****** URL RESPONSE ********\n" + urlInfo
        
        if showHeader == true {
            let header = "Headers:\n" + allHeaderFields.debugDescription
            info = info + header + "\n"
        }
        
        if let body = body {
            let bodyString = NSString(data: body, encoding: String.Encoding.utf8.rawValue) as! String
            let bodyInfo = "Body:\n" + bodyString
            info = info + bodyInfo
        }
        
        info = info + "\n\n"
        
        return info
    }
}
