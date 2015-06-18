//
//  Preferences.swift
//  Menubar Colors
//
//  Created by Nikolai Vazquez on 6/18/15.
//  Copyright (c) 2015 Nikolai Vazquez. All rights reserved.
//

import Cocoa

class Preferences: NSObject {
    
    var resetPositionUponOpen: Bool
    
    init(resetPositionUponOpen: Bool) {
        self.resetPositionUponOpen = resetPositionUponOpen
    }

}
