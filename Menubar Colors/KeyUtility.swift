//
//  KeyUtility.swift
//  Menubar Colors
//
//  Created by Nikolai Vazquez on 6/2/15.
//  Copyright (c) 2015 Nikolai Vazquez. All rights reserved.
//

import Cocoa

private let capslockKey     = NSEventModifierFlags.AlphaShiftKeyMask.rawValue
private let commandKey      = NSEventModifierFlags.CommandKeyMask.rawValue
private let commandShiftKey = NSEventModifierFlags.CommandKeyMask.rawValue | NSEventModifierFlags.ShiftKeyMask.rawValue

func performShortcut(event: NSEvent, from window: NSWindow) -> Bool {
    if event.type == NSEventType.KeyDown {
        let inputKey = event.charactersIgnoringModifiers!
        let modifierKey = event.modifierFlags.rawValue & NSEventModifierFlags.DeviceIndependentModifierFlagsMask.rawValue
        if (modifierKey == commandKey) || (modifierKey == commandKey | capslockKey) {
            switch event.charactersIgnoringModifiers! {
            case Regex(pattern: "[Qq]"):
                NSLog("Quit")
                NSApplication.sharedApplication().terminate(window)
            case Regex(pattern: "[Ww]"):
                NSLog("Close Window")
                window.close()
                return true
            case Regex(pattern: "[Hh]"):
                let appName = NSBundle.mainBundle().infoDictionary!["CFBundleName"] as! String
                NSLog("Hide \(appName)")
                NSApplication.sharedApplication().hide(window)
                return true
            case Regex(pattern: "[Xx]"):
                NSLog("Cut")
                if NSApp.sendAction(Selector("cut:"), to: nil, from: window) { return true }
            case Regex(pattern: "[Cc]"):
                NSLog("Copy")
                if NSApp.sendAction(Selector("copy:"), to: nil, from: window) { return true }
            case Regex(pattern: "[Vv]"):
                NSLog("Paste")
                if NSApp.sendAction(Selector("paste:"), to: nil, from: window) { return true }
            case Regex(pattern: "[Zz]"):
                NSLog("Undo")
                if NSApp.sendAction(Selector("undo:"), to: nil, from: window) { return true }
            case Regex(pattern: "[Aa]"):
                NSLog("Select All")
                if NSApp.sendAction(Selector("selectAll:"), to: nil, from: window) { return true }
            default:
                break
            }
        } else if (modifierKey == commandShiftKey) || (modifierKey == commandShiftKey | capslockKey) {
            switch event.charactersIgnoringModifiers! {
            case Regex(pattern: "[Zz]"):
                NSLog("Redo")
                if NSApp.sendAction(Selector("redo:"), to: nil, from: window) { return true }
            default:
                break
            }
        }
    }
    return false
}
