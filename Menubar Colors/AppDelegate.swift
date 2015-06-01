//
//  AppDelegate.swift
//  Menubar Colors
//
//  Created by Nikolai Vazquez on 5/30/15.
//  Copyright (c) 2015 Nikolai Vazquez. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSMenuDelegate {
    
    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var colorsMenuItem: NSMenuItem!
    
    let startTime = NSDate()
    var executionTime: NSTimeInterval {
        get {
            let endTime = NSDate()
            return endTime.timeIntervalSinceDate(startTime)
        }
    }
    
    var colorPanel: NSColorPanel?
    
    var statusItem: NSStatusItem?
    var statusButton: NSStatusBarButton?
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        //Set icon image
        let icon = NSImage(named: "statusIcon")
        icon!.setTemplate(true)
        statusItem!.image = icon
    }
    
    override func awakeFromNib() {
        colorPanel = NSColorPanel()
        colorPanel?.hidesOnDeactivate = false
        
        //Set status bar item to default size
        let statusBar = NSStatusBar.systemStatusBar()
        statusItem = statusBar.statusItemWithLength(-1)
        
        statusButton         = statusItem!.button!
        statusButton?.target = self
        statusButton?.action = "statusButtonPressed:"
        statusButton?.sendActionOn(Int((NSEventMask.LeftMouseUpMask | NSEventMask.RightMouseUpMask).rawValue))
        
        statusMenu.delegate = self
        
        colorsMenuItem.title = "Open Colors"
        
    }
    
    func statusButtonPressed(sender: NSStatusBarButton!) {
        var event: NSEvent! = NSApp.currentEvent!
        if (event.type == NSEventType.RightMouseUp) {
            statusItem?.menu = statusMenu
            statusItem?.popUpStatusItemMenu(statusMenu)
        } else {
            adjustColorPanel()
        }
    }
    
    //Disable left click menu upon close
    func menuDidClose(menu: NSMenu) {
        statusItem?.menu = nil
    }
    
    func adjustColorPanel() {
        NSLog("adjustColorPanel() called")
        if (colorPanel?.visible)! == false {
            openColorPanel()
        } else {
            closeColorPanel()
        }
    }
    
    func openColorPanel() {
        NSLog("Opening color panel")
        colorPanel?.makeKeyAndOrderFront(self)
        colorsMenuItem.title = "Hide Colors"
    }
    
    func closeColorPanel() {
        NSLog("Closing color panel")
        colorPanel?.orderOut(self)
        colorsMenuItem.title = "Show Colors"
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
        NSLog("Terminating...\nExecution time = %f seconds", executionTime)
    }
    
    @IBAction func colorsMenuItemSelected(sender: NSMenuItem) {
        adjustColorPanel()
    }
    

}

