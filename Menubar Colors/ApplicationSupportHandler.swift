//
//  ApplicationSupportHandler.swift
//  Menubar Colors
//
//  Created by Nikolai Vazquez on 6/15/15.
//  Copyright (c) 2015 Nikolai Vazquez. All rights reserved.
//

import Cocoa

class ApplicationSupportHandler: NSObject {
    
    let directory: String
    var files: [String] {
        if let contents = NSFileManager.defaultManager().contentsOfDirectoryAtPath(directory, error: nil) {
            return contents as! [String]
        } else {
            return [String]()
        }
    }
    
    override init() {
        let appName = NSBundle.mainBundle().infoDictionary!["CFBundleName"] as! String
        directory = (NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.ApplicationSupportDirectory, NSSearchPathDomainMask.AllDomainsMask, true)[0] as! String).stringByAppendingPathComponent(appName)
    }
    
}