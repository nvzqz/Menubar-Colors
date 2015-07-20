//
//  ColorPanel.swift
//  Menubar Colors
//
//  Created by Nikolai Vazquez on 7/20/15.
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

class ColorPanel: NSColorPanel {
    
    // MARK: Variables
    
    private var framePadding: CGFloat {
        return SystemInfo.ScreenSize.width / 160 * self.backingScaleFactor
    }
    
    // MARK: Methods
    
    func moveToScreenLocation(location: Location) {
        
        func newTopLeftPoint() -> NSPoint? {
            let screenBounds = SystemInfo.ScreenBounds
            switch location {
            case .TopLeft:
                return NSMakePoint(
                    screenBounds.minX + framePadding,
                    screenBounds.maxY - framePadding
                )
            case .TopRight:
                return NSMakePoint(
                    screenBounds.maxX - frame.width - framePadding,
                    screenBounds.maxY - framePadding
                )
            case .None:
                return nil
            }
        }
        
        if let point = newTopLeftPoint() {
            self.setFrameTopLeftPoint(point)
        }
        
    }
    
    // MARK: IB Methods
    
    @IBAction func open(sender: AnyObject?) {
        let location = Preferences.sharedPreferences.resetLocation
        self.moveToScreenLocation(location)
        self.makeKeyAndOrderFront(sender)
    }

}
