//
//  MenubarColorPanel.swift
//  Menubar Colors
//
//  Created by Nikolai Vazquez on 6/2/15.
//  Copyright (c) 2015 Nikolai Vazquez. All rights reserved.
//

import Cocoa

class MenubarColorPanel: NSColorPanel {
    
    private let screenBounds: NSRect = NSScreen.mainScreen()!.visibleFrame
    private let screenSize:   NSRect = NSScreen.mainScreen()!.frame

    var resetPositionUponOpen: Bool = false
    
    override func performKeyEquivalent(event: NSEvent) -> Bool {
        if performShortcut(event, from: self) {
            return true
        } else {
            return super.performKeyEquivalent(event)
        }
    }
    
    func show() {
        if resetPositionUponOpen {
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
