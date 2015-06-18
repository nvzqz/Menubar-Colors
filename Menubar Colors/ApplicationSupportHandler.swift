//
//  ApplicationSupportHandler.swift
//  Menubar Colors
//
//  Created by Nikolai Vazquez on 6/15/15.
//  Copyright (c) 2015 Nikolai Vazquez. All rights reserved.
//

import Cocoa

class ApplicationSupportHandler: NSObject {
    
    var directory: File
    var preferencesFile: File
    
    override init() {
        let appName = NSBundle.mainBundle().infoDictionary!["CFBundleName"] as! String
        directory = File(path: (NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.ApplicationSupportDirectory, NSSearchPathDomainMask.AllDomainsMask, true)[0] as! String).stringByAppendingPathComponent(appName))
        preferencesFile = File(path: directory.path.stringByAppendingPathComponent("preferences"))
    }
    
}