//
//  CompetitionStandings.swift
//  PrisonerDilemma
//
//  Created by Ben Dolmar on 1/20/16.
//  Copyright © 2016 Ben Dolmar. All rights reserved.
//

import Foundation

struct CompetitionStandings {
    var leaderboard: [Prisoner]
    var currentRound: CompetitionRound
    var disciplineLeaderboard: [DisciplineStatistics]
    
    init(leaderboard: [Prisoner], currentRound: CompetitionRound, disciplineLeaderboard: [DisciplineStatistics]) {
        self.leaderboard = leaderboard
        self.currentRound = currentRound
        self.disciplineLeaderboard = disciplineLeaderboard
    }
}