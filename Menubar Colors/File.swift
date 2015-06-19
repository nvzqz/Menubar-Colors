//
//  File.swift
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

class File: NSObject {
    
    var path: String
    var encoding: UInt
    
    var writable: Bool {
        return NSFileManager.defaultManager().isWritableFileAtPath(path)
    }
    
    var exists: Bool {
        return NSFileManager.defaultManager().fileExistsAtPath(path)
    }
    
    var parent: File {
        return File(path: path.stringByDeletingLastPathComponent)
    }
    
    init(path: String, encoding: UInt = NSUTF8StringEncoding) {
        self.path = path
        self.encoding = encoding
    }
    
    func createFile() -> Bool {
        return NSFileManager.defaultManager().createFileAtPath(path, contents: nil, attributes: nil)
    }
    
    func createDirectory(intermediateDirectories createIntermediates: Bool = false) -> Bool {
        return NSFileManager.defaultManager().createDirectoryAtPath(path, withIntermediateDirectories: createIntermediates, attributes: nil, error: nil)
    }
    
}
