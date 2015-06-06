//
//  AboutWindow.swift
//  Menubar Colors
//
//  Created by Nikolai Vazquez on 6/5/15.
//  Copyright (c) 2015 Nikolai Vazquez. All rights reserved.
//

import Cocoa

class AboutWindow: NSWindow {
    
    private let capslockKey     = NSEventModifierFlags.AlphaShiftKeyMask.rawValue
    private let commandKey      = NSEventModifierFlags.CommandKeyMask.rawValue
    private let commandShiftKey = NSEventModifierFlags.CommandKeyMask.rawValue | NSEventModifierFlags.ShiftKeyMask.rawValue
    
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
                case Regex(pattern: "[Cc]"):
                    NSLog("Copy")
                    if NSApp.sendAction(Selector("copy:"), to: nil, from: self) { return true }
                case Regex(pattern: "[Aa]"):
                    NSLog("Select All")
                    if NSApp.sendAction(Selector("selectAll:"), to: nil, from: self) { return true }
                default:
                    break
                }
            }
        }
        return super.performKeyEquivalent(event)
    }
    
    override func cancelOperation(sender: AnyObject?) {
        close()
    }
    
    func open() {
        center()
        makeKeyAndOrderFront(delegate)
    }
    
}
