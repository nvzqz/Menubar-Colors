//
//  Preferences.swift
//  Menubar Colors
//
//  Created by Nikolai Vazquez on 6/18/15.
//  The MIT License (MIT)
//
//  Copyright (c) 2015 Nikolai Vazquez
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
