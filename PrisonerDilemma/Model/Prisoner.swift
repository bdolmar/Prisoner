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
    case TotalSentence = "totalSentenceYears"
    case ConfessionResponses = "confessions"
    case SilentResponses = "silents"
    case AverageRuntime = "averageRuntime"
}

struct Prisoner {
    private(set) var username: String = ""
    private(set) var discipline: Discipline = .Unknown
    private(set) var totalSentence: Int = 0
    private(set) var confessionResponses: Int = 0
    private(set) var silentResponses: Int = 0
    private(set) var averageRuntime: Int = 0

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
        
        if let totalSentenceAsNumber = json[PrisonerJSON.TotalSentence.rawValue] as? Int {
            self.totalSentence = totalSentenceAsNumber
        }
        
        if let confessionResponsesAsNumber = json[PrisonerJSON.ConfessionResponses.rawValue] as? Int {
            self.confessionResponses = confessionResponsesAsNumber
        }
        
        if let silentResponsesAsNumber = json[PrisonerJSON.SilentResponses.rawValue] as? Int {
            self.silentResponses = silentResponsesAsNumber
        }
        
        if let averageRuntimeAsNumber = json[PrisonerJSON.AverageRuntime.rawValue] as? Int {
            self.averageRuntime = averageRuntimeAsNumber
        }
    }
}