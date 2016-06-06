//
//  AppDelegate.swift
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

@NSApplicationMain

// - MARK: AppDelegate Class
class AppDelegate: NSObject, NSApplicationDelegate {
    
    // MARK: Variables
    
    @IBOutlet weak var colorPanel: ColorPanel!

    @IBOutlet weak var statusMenu: StatusMenu!
    var statusItem: NSStatusItem!
    
    let aboutWindowController: AboutWindowController = AboutWindowController(windowNibName: "AboutWindow")
    
    // MARK: NSApplicationDelegate Methods
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
        let statusBar = NSStatusBar.systemStatusBar()
        statusItem = statusBar.statusItemWithLength(-1)
        
        let icon = NSImage(named: "menu-icon")
        icon?.template = true
        statusItem.image = icon
        
        let button = statusItem.button
        button?.toolTip = "Click to show color panel\nRight click to show menu"
        button?.target = self
        button?.action = #selector(AppDelegate.statusButtonPressed(_:))
        button?.sendActionOn(Int(NSEventMask.LeftMouseUpMask.union(.RightMouseUpMask).rawValue))
        
        statusMenu.delegate = self
        
        // MARK: Populate "Reset Location" menu
        
        let menu: NSMenu = statusMenu.resetPositionMenu
        
        for location in Location.CasesArray {
            let item = NSMenuItem(
                title: location.description,
                action: #selector(AppDelegate.setResetLocation(_:)),
                keyEquivalent: ""
            )
            if location == Preferences.sharedPreferences().resetLocation {
                item.state = NSOnState
            }
            menu.addItem(item)
        }
        
        colorPanel.showsAlpha = Preferences.sharedPreferences().showsAlpha
        if let item = statusMenu.itemWithTitle("Show Alpha") {
            item.state = colorPanel.showsAlpha ? NSOnState : NSOffState
        }
        
    }
    
    // MARK: Selector Methods
    
    func statusButtonPressed(sender: NSStatusBarButton) {
        if let event = NSApplication.sharedApplication().currentEvent {
            if event.modifierFlags.contains(.ControlKeyMask) || event.type == .RightMouseUp {
                // Handle right mouse click
                statusItem.menu = statusMenu
                statusItem.popUpStatusItemMenu(statusMenu)
            } else {
                // Handle left mouse click
                self.toggleColorPanel(sender)
            }
        }
    }
    
    func setResetLocation(sender: NSMenuItem) {
        if let location = Location.CasesDictionary[sender.title] {
            
            colorPanel.moveToScreenLocation(location)
            Preferences.sharedPreferences().resetLocation = location
            
            if sender.action == #selector(AppDelegate.setResetLocation(_:)) {
                for item in sender.menu!.itemArray {
                    if item.action == sender.action {
                        item.state = (item == sender) ? NSOnState : NSOffState
                    }
                }
            }
            
        }
    }
    
    // MARK: IB Methods
    
    @IBAction func toggleColorPanel(sender: AnyObject) {
        if colorPanel.visible {
            colorPanel.close()
        } else {
            colorPanel.open(sender)
        }
    }
    
    @IBAction func toggleStartAtLogin(sender: AnyObject) {
        let manager = LoginItemsManager()
        manager.toggleStartAtLogin()
    }
    
    @IBAction func showAbout(sender: AnyObject?) {
        aboutWindowController.showWindow(sender)
    }
    
    @IBAction func openProjectURL(sender: AnyObject?) {
        NSWorkspace.sharedWorkspace().openURL(NSURL(string: "https://github.com/nvzqz/Menubar-Colors")!)
    }

}

// MARK: - NSMenuDelegate Extension

extension AppDelegate: NSMenuDelegate {
    
    // MARK: NSMenuDelegate Methods

    func menuWillOpen(menu: NSMenu) {
        if let statusMenu = menu as? StatusMenu {
            
            if let startAtLoginItem = statusMenu.itemWithTitle("Start at Login") {
                let manager = LoginItemsManager()
                if manager.startAtLogin {
                    startAtLoginItem.state = NSOnState
                } else {
                    startAtLoginItem.state = NSOffState
                }
            }
            
            if colorPanel.visible {
                statusMenu.toggleColorsItem.title = "Hide Colors"
            } else {
                statusMenu.toggleColorsItem.title = "Show Colors"
            }
            
        }
    }
    
    func menuDidClose(menu: NSMenu) {
        statusItem.menu = nil
    }

}

