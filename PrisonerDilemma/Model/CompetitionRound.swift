//
//  CompetitionRound.swift
//  PrisonerDilemma
//
//  Created by Ben Dolmar on 1/20/16.
//  Copyright © 2016 Ben Dolmar. All rights reserved.
//

import Foundation

struct CompetitionRound {
    var player1: PrisonerEntry
    var player2: PrisonerEntry
    var roundNumber: Int = 0
    var startDate: NSDate = NSDate()
    
    init(player1: PrisonerEntry, player2: PrisonerEntry, json: Dictionary<String, AnyObject>) {
        self.player1 = player1
        self.player2 = player2
        // Had to define these for the compiler to catch that hydrate updates it
        
        self.hydrateWithJSON(player1, player2: player2, json: json)
    }
    
    mutating func hydrateWithJSON(player1: PrisonerEntry, player2: PrisonerEntry, json: Dictionary<String, AnyObject>) -> Void {
        self.player1 = player1
        self.player2 = player2
        
        if let roundNumberAsNumber = json["interrogationIndex"] as? Int {
            self.roundNumber = roundNumberAsNumber
        }
        
        if let startDateAsString = json["startDate"] as? String {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS"
            self.startDate = dateFormatter.dateFromString(startDateAsString)!
        }
    }
}