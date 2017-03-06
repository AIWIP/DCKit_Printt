//
//  NSURLRequest+DebugPrint.swift
//  DCKit
//
//  Created by Marko Strizic on 09/09/15.
//  Copyright (c) 2015 DECODE. All rights reserved.
//

import Foundation

public extension URLRequest {
    
    public func dc_debugDescription(showHeader:Bool, showBody:Bool) -> String {
        
        
        let urlInfo = "URL: (" + httpMethod! + ") " + url!.absoluteString + "\n"
        
        var info = "\n\n****** URL REQUEST ********\n" + urlInfo
        
        if let headerFields = allHTTPHeaderFields?.description , showHeader == true {
            let header = "Headers:\n" + headerFields
            info = info + header + "\n"
        }
        
        
        
        if let body = httpBody , showBody == true{
            let bodyString = NSString(data: body, encoding: String.Encoding.utf8.rawValue) as! String
            let bodyInfo = "Body:\n" + bodyString
            info = info + bodyInfo
        }
        
        info = info + "\n\n"
        
        return info
    }
}
