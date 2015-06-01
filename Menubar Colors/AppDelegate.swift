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
    
    let startTime = NSDate()
    
    var colorPanel: NSColorPanel?
    var colorPanelOpen: Bool = false
    
    var statusItem: NSStatusItem?
    var statusButton: NSStatusBarButton?
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        //Set icon image
        let icon = NSImage(named: "statusIcon")
        icon!.setTemplate(true)
        statusItem!.image = icon
        
        colorPanel?.worksWhenModal = true
    }
    
    override func awakeFromNib() {
        //Set status bar item to default size
        println(startTime)
        let statusBar = NSStatusBar.systemStatusBar()
        statusItem = statusBar.statusItemWithLength(-1)
        
        statusButton         = statusItem!.button!
        statusButton?.target = self
        statusButton?.action = "statusButtonPressed:"
        statusButton?.sendActionOn(Int((NSEventMask.LeftMouseUpMask | NSEventMask.RightMouseUpMask).rawValue))
        
        statusMenu.delegate = self
        
        colorPanel = NSColorPanel()
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
        println("adjustColorPanel() called at \(NSDate())")
        if (colorPanel?.visible)! == false {
            println("Opening color panel")
            colorPanel?.makeKeyAndOrderFront(self)
        } else {
            println("Closing color panel")
            colorPanel?.orderOut(self)
        }
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
        println("Terminating...")
    }
    
    @IBAction func colorsMenuItemSelected(sender: NSMenuItem) {
        adjustColorPanel()
    }
    

}

