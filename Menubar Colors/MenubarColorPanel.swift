//
//  MenubarColorPanel.swift
//  Menubar Colors
//
//  Created by Nikolai Vazquez on 6/2/15.
//  Copyright (c) 2015 Nikolai Vazquez. All rights reserved.
//

import Cocoa

class MenubarColorPanel: NSColorPanel {
    
    override func performKeyEquivalent(event: NSEvent) -> Bool {
        if performShortcut(event, from: self) {
            return true
        } else {
            return super.performKeyEquivalent(event)
        }
    }
    
}
