//
//  CompetitionRoundEntry.swift
//  PrisonerDilemma
//
//  Created by Adam Ranfelt on 1/21/16.
//  Copyright © 2016 Ben Dolmar. All rights reserved.
//

import Foundation

private enum PrisonerEntryJSON: String {
    case LastResponse = "lastResponse"
}

struct PrisonerEntry {
    private(set) var entrant: Prisoner
    private(set) var discipline: Discipline = .Unknown
    private(set) var lastResponse: Responses = .Silent
    
    init(entrant: Prisoner, json: Dictionary<String, AnyObject>) {
        self.entrant = entrant
        // Had to define these for the compiler to catch that hydrate updates it
        self.discipline = entrant.discipline
        self.lastResponse = .Silent
        
        self.hydrateWithJSON(entrant, json: json)
    }
    
    mutating func hydrateWithJSON(entrant: Prisoner, json: Dictionary<String, AnyObject>) -> Void {
        self.entrant = entrant
        self.discipline = entrant.discipline
        
        if let lastResponseAsStr = json[PrisonerEntryJSON.LastResponse.rawValue] as? String,
            lastResponseAsEnum = Responses(rawValue: lastResponseAsStr) {
            lastResponse = lastResponseAsEnum
        }
    }
}