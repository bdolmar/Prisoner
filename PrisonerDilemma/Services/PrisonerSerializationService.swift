//
//  JSONSerializerPipelineComponent.swift
//  PrisonerDilemma
//
//  Created by Adam Ranfelt on 1/21/16.
//  Copyright © 2016 Ben Dolmar. All rights reserved.
//

import Foundation
import Genome

class PrisonerSerializationPipeline {
    
}

extension PrisonerSerializationPipeline {
    private func buildPrisonerList(entrants: [Dictionary<String, AnyObject>]) -> [Prisoner] {
        return entrants.map { (json) -> Prisoner in
            return Prisoner(json: json)
        }
    }
    
    private func buildDisciplineStatistics(disciplines: [Dictionary<String, AnyObject>]) -> [DisciplineStatistics] {
        return disciplines.map { (json) -> DisciplineStatistics in
            return DisciplineStatistics(json: json)
        }
    }
    
    private func buildCompetitionRound(prisoners: [Prisoner], round: Dictionary<String, AnyObject>) throws -> CompetitionRound {
        guard let player1 = round["entrant1"] as? Dictionary<String, AnyObject> else {
            throw SerializationPipelineErrors.MissingProperties
        }
        
        guard let player1Username = player1["username"] as? String else {
            throw SerializationPipelineErrors.MissingProperties
        }
        
        guard let player2 = round["entrant2"] as? Dictionary<String, AnyObject> else {
            throw SerializationPipelineErrors.MissingProperties
        }
        
        guard let player2Username = player2["username"] as? String else {
            throw SerializationPipelineErrors.MissingProperties
        }
        
        let prisoner1 = prisoners.filter { (prisoner) -> Bool in
            return prisoner.username == player1Username
        }.first
        
        let prisoner2 = prisoners.filter { (prisoner) -> Bool in
            return prisoner.username == player2Username
        }.first
        
        
        return CompetitionRound(player1: prisoner1!, player2: prisoner2!, json: round)
    }
    
    func serialize(data: NSData) throws -> Dictionary<String, AnyObject> {
        let parsedData = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
        
        if let jsonData = parsedData as? Dictionary<String, AnyObject> {
            return jsonData
        } else {
            throw SerializationPipelineErrors.MalformedJSON
        }
    }
    
    func transform(json: Dictionary<String, AnyObject>) throws -> CompetitionStandings {
        guard let prisonerJson = json["entrantRankings"] as? [Dictionary<String, AnyObject>] else {
            throw SerializationPipelineErrors.MissingProperties
        }
        
        guard let disciplineJson = json["disciplineRankings"] as? [Dictionary<String, AnyObject>] else {
            throw SerializationPipelineErrors.MissingProperties
        }
        
        guard let roundJson = json["currentMatch"] as? Dictionary<String, AnyObject> else {
            throw SerializationPipelineErrors.MissingProperties
        }
        
        let prisoners = self.buildPrisonerList(prisonerJson)
        let disciplines = self.buildDisciplineStatistics(disciplineJson)
        let competitionRound = try self.buildCompetitionRound(prisoners, round: roundJson)
        
        return CompetitionStandings(leaderboard: prisoners, currentRound: competitionRound, disciplineLeaderboard: disciplines)
    }
}

enum SerializationPipelineErrors : ErrorType {
    case MalformedJSON
    case MissingProperties
}