//
//  Discipline.swift
//  PrisonerDilemma
//
//  Created by Adam Ranfelt on 1/21/16.
//  Copyright © 2016 Ben Dolmar. All rights reserved.
//

import Foundation

private enum DisciplineStatisticsJSON : String {
    case Name = "name"
    case AverageSentence = "averageSentenceYears"
    case NumberOfEntrants = "entrants"
    case NumberOfConfessionResponses = "confessions"
    case NumberOfSilentResponses = "silents"
    case AverageRuntime = "averageRuntime"
}

struct DisciplineStatistics {
    private(set) var name: Discipline = .Unknown
    private(set) var averageSentence: Int = 0
    private(set) var numberOfEntrants: Int = 0
    private(set) var numberOfConfessionResponses: Int = 0
    private(set) var numberOfSilentResponses: Int = 0
    private(set) var averageRuntime: Int = 0
    
    init(json: Dictionary<String, AnyObject>) {
        self.fromJSON(json)
    }
    
    mutating func fromJSON(json: Dictionary<String, AnyObject>) -> Void {
        if let nameAsStr = json[DisciplineStatisticsJSON.Name.rawValue] as? String, nameAsEnum = Discipline(rawValue: nameAsStr) {
            self.name = nameAsEnum
        }
        
        if let averageSentenceAsNumber = json[DisciplineStatisticsJSON.AverageRuntime.rawValue] as? Int {
            self.averageRuntime = averageSentenceAsNumber
        }
        
        if let numberOfEntrantsAsNumber = json[DisciplineStatisticsJSON.NumberOfEntrants.rawValue] as? Int {
            self.numberOfEntrants = numberOfEntrantsAsNumber
        }
        
        if let numberOfConfessionResponsesAsNumber = json[DisciplineStatisticsJSON.NumberOfConfessionResponses.rawValue] as? Int {
            self.numberOfConfessionResponses = numberOfConfessionResponsesAsNumber
        }
        
        if let numberOfSilentResponsesAsNumber = json[DisciplineStatisticsJSON.NumberOfConfessionResponses.rawValue] as? Int {
            self.numberOfSilentResponses = numberOfSilentResponsesAsNumber
        }
        
        if let averageRuntimeAsNumber = json[DisciplineStatisticsJSON.AverageRuntime.rawValue] as? Int {
            self.averageRuntime = averageRuntimeAsNumber
        }
    }
}