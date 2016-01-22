//
//  StatisticsConsumer.swift
//  PrisonerDilemma
//
//  Created by Adam Ranfelt on 1/22/16.
//  Copyright © 2016 Ben Dolmar. All rights reserved.
//

import Foundation

protocol StatisticsConsumer {
    func useCompetitionStandings(standings: CompetitionStandings) -> Void
}