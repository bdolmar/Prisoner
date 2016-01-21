//
//  CompetitionStandings.swift
//  PrisonerDilemma
//
//  Created by Ben Dolmar on 1/20/16.
//  Copyright © 2016 Ben Dolmar. All rights reserved.
//

import Foundation

class CompetitionStandings {
    var leaderboard: [Prisoner] = []
    var currentRound: CompetitionRound
}

//MARK: - Genome Support

extension Prisoner : BasicMappable {
    
}