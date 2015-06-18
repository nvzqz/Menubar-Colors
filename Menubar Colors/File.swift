//
//  File.swift
//  Menubar Colors
//
//  Created by Nikolai Vazquez on 6/18/15.
//  Copyright (c) 2015 Nikolai Vazquez. All rights reserved.
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
