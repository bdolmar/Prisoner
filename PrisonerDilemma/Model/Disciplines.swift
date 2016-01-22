//
//  Disciplines.swift
//  PrisonerDilemma
//
//  Created by Ben Dolmar on 1/20/16.
//  Copyright © 2016 Ben Dolmar. All rights reserved.
//

import Cocoa

enum Discipline: String {
    case Mobile = "mobile"
    case DotNet = ".net"
    case PHP = "php"
    case Ruby = "ruby"
    case JVM = "jvm"
    case ClientSide = "client-side"
    case Unknown = "unknown"
    
    func associatedColor() -> NSColor {
        var result: NSColor
        
        switch (self) {
            case .Mobile:
                result = NSColor(calibratedRed: 42/255, green: 135/255, blue: 111/255, alpha: 1.0)
            case .DotNet:
                result = NSColor(calibratedRed: 41/256, green: 60/256, blue: 45/255, alpha: 1.0)
            case .PHP:
                result = NSColor(calibratedRed: 66/256, green: 36/256, blue: 41/256, alpha: 1.0)
            case .Ruby:
                result = NSColor(calibratedRed: 0/256, green: 215/256, blue: 225/256, alpha: 1.0)
            case .JVM:
                result = NSColor(calibratedRed: 0/256, green: 123/256, blue: 137/256, alpha: 1.0)
            case .ClientSide:
                result = NSColor(calibratedRed: 226/256, green: 222/256, blue: 0/256, alpha: 1.0)
            default:
                result = NSColor(calibratedRed: 128/256, green: 128/256, blue: 128/256, alpha: 1.0)
        }
        
        return result
    }
}