//
//  Prisoner.swift
//  PrisonerDilemma
//
//  Created by Ben Dolmar on 12/25/15.
//  Copyright © 2015 Ben Dolmar. All rights reserved.
//

import Foundation
import Genome

private enum PrisonerJSON : String {
    case Username = "username"
    case Discipline = "discipline"
    case Sentence = "sentenceYears"
    case ConfessionResponses = "confessions"
    case SilentResponses = "silents"
    case AverageRuntime = "averageRuntime"
}

struct Prisoner {
    var username: String = ""
    var discipline: Discipline = .Unknown
    var sentence: Int = 0
    
    var fullname: String {
        if Prisoner.lookupTable == nil {
            Prisoner.loadLookupTable()
        }
        
        if let lookupTable = Prisoner.lookupTable, fullname = lookupTable[self.username]?["fullName"] {
            return fullname
        } else {
            return ""
        }
    }

    var firstname: String {
        if Prisoner.lookupTable == nil {
            Prisoner.loadLookupTable()
        }
        
        if let lookupTable = Prisoner.lookupTable, fullname = lookupTable[self.username]?["firstName"] {
            return fullname
        } else {
            return ""
        }
    }

    init(username: String, discipline: Discipline, sentence: Int) {
        self.username = username
        self.discipline = discipline
        self.sentence = sentence
    }

    init(json: JSON) {
        self.fromJSON(json)
    }
    
    mutating func fromJSON(json: JSON) -> Void {
        if let usernameAsStr = json[PrisonerJSON.Username.rawValue] as? String {
            self.username = usernameAsStr
        }
        
        if let disciplineAsStr = json[PrisonerJSON.Discipline.rawValue] as? String, disciplineAsEnum = Discipline(rawValue: disciplineAsStr) {
            self.discipline = disciplineAsEnum
        }
        
        if let totalSentenceAsNumber = json[PrisonerJSON.Sentence.rawValue] as? Int {
            self.sentence = totalSentenceAsNumber
        }        
    }
}

//MARK: - Lookup Table Logid

extension Prisoner {
    private static var lookupTable: [String: [String: String]]?
    
    private static func loadLookupTable() {
        if let path = NSBundle.mainBundle().pathForResource("Prisoners", ofType: "plist"),
            lookupTable = NSDictionary(contentsOfFile: path) as? [String: [String: String]] {
                Prisoner.lookupTable = lookupTable
        }
    }
}