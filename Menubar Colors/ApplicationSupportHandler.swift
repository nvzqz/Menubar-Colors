//
//  ApplicationSupportHandler.swift
//  Menubar Colors
//
//  Created by Nikolai Vazquez on 6/15/15.
//  Copyright (c) 2015 Nikolai Vazquez. All rights reserved.
//

import Cocoa

class ApplicationSupportHandler: NSObject {
    
    static private var handler: ApplicationSupportHandler?
    
    var directory: File
    var preferences: Preferences
    
    override init() {
        let appName = NSBundle.mainBundle().infoDictionary!["CFBundleName"] as! String
        directory = File(path: (NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.ApplicationSupportDirectory, NSSearchPathDomainMask.AllDomainsMask, true)[0] as! String).stringByAppendingPathComponent(appName))
        preferences = Preferences(file: directory.path.stringByAppendingPathComponent("Preferences.plist"))
    }
    
    static func defaultHandler() -> ApplicationSupportHandler {
        if let defaultHandler = handler {
            return defaultHandler
        } else {
            handler = ApplicationSupportHandler()
            return handler!
        }
    }
    
}