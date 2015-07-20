//
//  LoginItemsManager.swift
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


import Foundation

class LoginItemsManager {
    
    // MARK: Variables

    var startAtLogin: Bool {
        get {
            return itemReferencesInLoginItems().thisReference != nil
        } set {
            makeLoginItem(newValue)
        }
    }
    
    private var loginItemsReference: LSSharedFileListRef? {
        return LSSharedFileListCreate(
            nil,
            kLSSharedFileListSessionLoginItems.takeRetainedValue(),
            nil
            ).takeRetainedValue() as LSSharedFileListRef?
    }
    
    // MARK: Initialization
    
    init() {}
    
    // MARK: Methods

    func toggleStartAtLogin() {
        startAtLogin = !startAtLogin
    }

    private func makeLoginItem(shouldBeLoginItem: Bool) {
        let itemReferences = itemReferencesInLoginItems()
        if let loginItemsRef = loginItemsReference {
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
        if let loginItemsRef = loginItemsReference {
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

}