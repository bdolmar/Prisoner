//
//  Prisoner.swift
//  PrisonerDilemma
//
//  Created by Ben Dolmar on 12/25/15.
//  Copyright © 2015 Ben Dolmar. All rights reserved.
//

import Foundation
import Genome

struct Prisoner {
    var username: String = ""
    var discipline: Discipline = .Unknown
    var sentence: Int = 0
    var confessions: Int = 0
    var silents: Int = 0
    var averageRuntime: Int = 0
}

//MARK: - Genome Support

extension Prisoner : BasicMappable {
    mutating func sequence(map: Map) throws {
        try username <~> map["username"]
        try discipline <~ map["discipline"].transformFromJson {
            if let parsedDiscipline = Discipline(rawValue: $0.rawValue) {
                return parsedDiscipline
            } else {
                return .Unknown
            }
        }
        try sentence <~> map["sentence"]
        try confessions ~> map["confessions"]
        try silents <~> map["silents"]
        try averageRuntime <~> map["averageRuntime"]
    }
}