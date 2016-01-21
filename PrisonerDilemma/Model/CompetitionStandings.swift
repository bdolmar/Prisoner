//
//  CompetitionStandings.swift
//  PrisonerDilemma
//
//  Created by Ben Dolmar on 1/20/16.
//  Copyright © 2016 Ben Dolmar. All rights reserved.
//

import Foundation
import Genome

struct CompetitionStandings {
    var leaderboard: [Prisoner] = []
    var currentRound: CompetitionRound = CompetitionRound(player1: Prisoner(), player2: Prisoner(), roundNumber: 0)
}

//MARK: - Genome Support

extension CompetitionStandings : BasicMappable {
    mutating func sequence(map: Map) throws {
        try leaderboard <~> map["entrantRankings"]
        try currentRound <~> map["currentMatch"]
    }
}