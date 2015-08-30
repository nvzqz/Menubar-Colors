//
//  Preferences.swift
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

import Foundation

//  Mark: Preferences Class
class Preferences {
    
    // MARK: Preferences Keys
    
    private struct Keys {
        static var ResetLocation: String = "Reset Location"
        static var ShowsAlpha: String = "Shows Alpha"
    }
    
    // MARK: Shared Preferences
    
    private static let _sharedPreferences = Preferences()
    
    static func sharedPreferences() -> Preferences { return _sharedPreferences }
    
    // MARK: Private Variables
    
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    // MARK: Variables
    
    var resetLocation: Location {
        get {
            if let resetLocation = defaults.objectForKey(Keys.ResetLocation) as? String {
                if let location: Location = Location.CasesDictionary[resetLocation] {
                    return location
                }
            }
            return .None
        }
        set {
            defaults.setValue(newValue.stringValue, forKey: Keys.ResetLocation)
        }
    }
    
    var showsAlpha: Bool {
        get {
            return defaults.objectForKey(Keys.ShowsAlpha) as? Bool ?? false
        }
        set {
            defaults.setBool(newValue, forKey: Keys.ShowsAlpha)
        }
    }
    
}
