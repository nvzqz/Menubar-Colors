//
//  Regex.swift
//  Menubar Colors
//
//  Created by Nikolai Vazquez on 6/2/15.
//  Copyright (c) 2015 Nikolai Vazquez. All rights reserved.
//

import Foundation

struct Regex {
    let pattern: String
    let options: NSRegularExpressionOptions!
    
    private var matcher: NSRegularExpression {
        return NSRegularExpression(pattern: self.pattern, options: self.options, error: nil)!
    }
    
    init(pattern: String, options: NSRegularExpressionOptions = nil) {
        self.pattern = pattern
        self.options = options
    }
    
    func match(string: String, options: NSMatchingOptions = nil) -> Bool {
        return self.matcher.numberOfMatchesInString(string, options: options, range: NSMakeRange(0, count(string.utf16))) != 0
    }
}

protocol RegularExpressionMatchable {
    func match(regex: Regex) -> Bool
}

extension String: RegularExpressionMatchable {
    func match(regex: Regex) -> Bool {
        return regex.match(self)
    }
}

func ~=<T: RegularExpressionMatchable>(pattern: Regex, matchable: T) -> Bool {
    return matchable.match(pattern)
}