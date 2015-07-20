//
//  AboutWindow.swift
//  Menubar Colors
//
//  Created by Nikolai Vazquez on 7/19/15.
//  Copyright (c) 2015 Nikolai Vazquez. All rights reserved.
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

class AboutWindow: NSWindow {
    
    @IBOutlet weak var versionLabel: NSTextField!
    @IBOutlet weak var copyrightLabel: NSTextField!
    
    override func awakeFromNib() {
        
        self.collectionBehavior = self.collectionBehavior | NSWindowCollectionBehavior.MoveToActiveSpace
        
        self.level = Int(CGWindowLevelKey((kCGModalPanelWindowLevelKey)))
        
        self.titlebarAppearsTransparent = true
        self.titleVisibility = .Hidden
        
        self.movableByWindowBackground = true
        
        if let view = self.contentView as? NSView {
            view.wantsLayer = true
            view.layer?.backgroundColor = NSColor.whiteColor().CGColor
        }
        
        versionLabel.stringValue = AppInfo.FormattedVersion
        copyrightLabel.stringValue = AppInfo.Copyright!
        
    }
    
    override func cancelOperation(sender: AnyObject?) {
        self.performClose(sender)
    }

}
