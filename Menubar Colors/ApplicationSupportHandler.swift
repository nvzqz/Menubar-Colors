//
//  ApplicationSupportHandler.swift
//  Menubar Colors
//
//  Created by Nikolai Vazquez on 6/15/15.
//  The MIT License (MIT)
//
//  Copyright (c) 2015 Nikolai Vazquez
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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