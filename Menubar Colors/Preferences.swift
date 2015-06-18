//
//  Preferences.swift
//  Menubar Colors
//
//  Created by Nikolai Vazquez on 6/18/15.
//  Copyright (c) 2015 Nikolai Vazquez. All rights reserved.
//

import Cocoa

class Preferences {
    
    private var resetPositionKey = "Reset Color Panel Position"
    
    var file: File
    var dictionary: NSMutableDictionary
    
    var resetPositionUponOpen: Bool {
        get {
            if let value = dictionary.objectForKey(resetPositionKey) as? Bool {
                return value
            } else {
                return false
            }
        } set {
            dictionary.setObject(newValue, forKey: resetPositionKey)
        }
    }
    
    init(file path: String) {
        self.file = File(path: path)
        if let dict = NSMutableDictionary(contentsOfFile: file.path) {
            self.dictionary = dict
        } else {
            self.dictionary = NSMutableDictionary()
        }
    }
    
    func write() -> Bool {
        return dictionary.writeToFile(file.path, atomically: false)
    }
    
    func read() -> NSMutableDictionary? {
        return NSMutableDictionary(contentsOfFile: file.path)
    }

}
