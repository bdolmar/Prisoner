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
