//
//  LoginItemsManager.swift
//  Menubar Colors
//
//  Created by Nikolai Vazquez on 6/19/15.
//  Copyright (c) 2015 Nikolai Vazquez. All rights reserved.
//

import Foundation

class LoginItemsManager {
    
    var startAtLogin: Bool {
        get {
            return itemReferencesInLoginItems().thisReference != nil
        } set {
            makeLoginItem(newValue)
        }
    }
    
    func toggleStartAtLogin() {
        startAtLogin = !startAtLogin
    }
    
    private func loginItemsReference() -> LSSharedFileListRef? {
        return LSSharedFileListCreate(
            nil,
            kLSSharedFileListSessionLoginItems.takeRetainedValue(),
            nil
            ).takeRetainedValue() as LSSharedFileListRef?
    }
    
    private func makeLoginItem(shouldBeLoginItem: Bool) {
        let itemReferences = itemReferencesInLoginItems()
        if let loginItemsRef = loginItemsReference() {
            if shouldBeLoginItem {
                let bundleURL: NSURL = NSBundle.mainBundle().bundleURL
                LSSharedFileListInsertItemURL(loginItemsRef, itemReferences.lastItemReference, nil, nil, bundleURL, nil, nil)
            } else {
                if let itemReference = itemReferences.thisReference {
                    LSSharedFileListItemRemove(loginItemsRef, itemReference)
                }
            }
        }
    }
    
    private func itemReferencesInLoginItems() -> (thisReference: LSSharedFileListItemRef?, lastItemReference: LSSharedFileListItemRef?) {
        let bundleURL: NSURL = NSBundle.mainBundle().bundleURL
        if let loginItemsRef = loginItemsReference() {
            let loginItems: NSArray = LSSharedFileListCopySnapshot(loginItemsRef, nil).takeRetainedValue() as NSArray
            if loginItems.count > 0 {
                let lastItemReference: LSSharedFileListItemRef = loginItems.lastObject as! LSSharedFileListItemRef
                for currentItemReference in loginItems as! [LSSharedFileListItemRef] {
                    let itemURL = LSSharedFileListItemCopyResolvedURL(currentItemReference, 0, nil)
                    if bundleURL.isEqual(itemURL.takeRetainedValue()) {
                        return (currentItemReference, lastItemReference)
                    }
                }
                return (nil, lastItemReference)
            } else {
                return (nil, kLSSharedFileListItemBeforeFirst.takeRetainedValue())
            }
        }
        return (nil, nil)
    }
    
    private static var manager: LoginItemsManager?
    
    static func defaultManager() -> LoginItemsManager {
        if manager == nil {
            manager = LoginItemsManager()
        }
        return manager!
    }
    
}