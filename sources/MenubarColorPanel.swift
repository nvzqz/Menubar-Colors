//
//  MenubarColorPanel.swift
//  Menubar Colors
//
//  Created by Nikolai Vazquez on 6/2/15.
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

class MenubarColorPanel: NSColorPanel {
    
    private let capslockKey     = NSEventModifierFlags.AlphaShiftKeyMask.rawValue
    private let commandKey      = NSEventModifierFlags.CommandKeyMask.rawValue
    private let commandShiftKey = NSEventModifierFlags.CommandKeyMask.rawValue | NSEventModifierFlags.ShiftKeyMask.rawValue
    
    private let screenBounds: NSRect = NSScreen.mainScreen()!.visibleFrame
    private let screenSize:   NSRect = NSScreen.mainScreen()!.frame
    
    override func performKeyEquivalent(event: NSEvent) -> Bool {
        if event.type == NSEventType.KeyDown {
            let inputKey = event.charactersIgnoringModifiers!
            let modifierKey = event.modifierFlags.rawValue & NSEventModifierFlags.DeviceIndependentModifierFlagsMask.rawValue
            if (modifierKey == commandKey) || (modifierKey == commandKey | capslockKey) {
                switch event.charactersIgnoringModifiers! {
                case Regex(pattern: "[Qq]"):
                    NSLog("Quit")
                    NSApplication.sharedApplication().terminate(self)
                case Regex(pattern: "[Ww]"):
                    NSLog("Close Window")
                    close()
                    return true
                case Regex(pattern: "[Hh]"):
                    let appName = NSBundle.mainBundle().infoDictionary!["CFBundleName"] as! String
                    NSLog("Hide \(appName)")
                    NSApplication.sharedApplication().hide(self)
                    return true
                case Regex(pattern: "[Xx]"):
                    NSLog("Cut")
                    if NSApp.sendAction(Selector("cut:"), to: nil, from: self) { return true }
                case Regex(pattern: "[Cc]"):
                    NSLog("Copy")
                    if NSApp.sendAction(Selector("copy:"), to: nil, from: self) { return true }
                case Regex(pattern: "[Vv]"):
                    NSLog("Paste")
                    if NSApp.sendAction(Selector("paste:"), to: nil, from: self) { return true }
                case Regex(pattern: "[Zz]"):
                    NSLog("Undo")
                    if NSApp.sendAction(Selector("undo:"), to: nil, from: self) { return true }
                case Regex(pattern: "[Aa]"):
                    NSLog("Select All")
                    if NSApp.sendAction(Selector("selectAll:"), to: nil, from: self) { return true }
                default:
                    break
                }
            } else if (modifierKey == commandShiftKey) || (modifierKey == commandShiftKey | capslockKey) {
                switch event.charactersIgnoringModifiers! {
                case Regex(pattern: "[Zz]"):
                    NSLog("Redo")
                    if NSApp.sendAction(Selector("redo:"), to: nil, from: self) { return true }
                default:
                    break
                }
            }
        }
        return super.performKeyEquivalent(event)
    }
    
    func show() {
        if ApplicationSupportHandler.defaultHandler().preferences.resetPositionUponOpen {
            moveToScreenTopRight()
        }
        makeKeyAndOrderFront(delegate)
    }
    
    func hide() {
        orderOut(delegate)
    }
    
    func toggleVisibility() {
        if visible {
            hide()
        } else {
            show()
        }
    }
    
    func moveToScreenTopRight() {
        
        var framePadding: CGFloat = screenSize.width / 160 * self.backingScaleFactor
        
        let newLocation: NSPoint = NSMakePoint(
            screenBounds.maxX - frame.width - framePadding,
            screenBounds.maxY - framePadding
        )
        setFrameTopLeftPoint(newLocation)
    }
    
}
