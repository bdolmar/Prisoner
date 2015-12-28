//
//  Prisoner.swift
//  PrisonerDilemma
//
//  Created by Ben Dolmar on 12/25/15.
//  Copyright © 2015 Ben Dolmar. All rights reserved.
//

import Foundation
import Genome

public struct Prisoner {
    public var player: String = ""
    public var discipline: String = ""
    public var appURL: NSURL = NSURL()
    
    public init() {}
    
    public var appType: PrisonerAppTypes {
        let pathComponent = self.appURL.lastPathComponent?.lowercaseString
        if let unwrappedPathComponent = pathComponent, appType = PrisonerAppTypes(rawValue: unwrappedPathComponent) {
            return appType
        } else {
            return .Native
        }
    }
}

extension Prisoner : BasicMappable {
    public mutating func sequence(map: Map) throws {
        try player <~> map["player"]
        try discipline <~> map["discipline"]
        try appURL <~> map["appURL"]
    }
}

public enum PrisonerAppTypes: String {
    case JVM = "jar"
    case DotNET = "exe"
    case Ruby = "rb"
    case PHP = "php"
    case Python = "py"
    case JavaScript = "js"
    case Native = "native"
    
}