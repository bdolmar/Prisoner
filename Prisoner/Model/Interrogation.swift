//
//  PrisonerArguments.swift
//  Prisoner
//
//  Created by Ben Dolmar on 12/23/15.
//  Copyright © 2015 Ben Dolmar. All rights reserved.
//

import Foundation

struct Interrogation {
    let partnerName: String
    let partnerDiscipline: String
    let partnerDidConfessPreviously: Bool?
    let playerDidConfessPreviously: Bool?
    
    init?(arguments: Array<String>) {        
        guard let partnerName = arguments[safe: .PartnerName],
                  partnerDiscipline = arguments[safe: .PartnerDiscipline]
        else {
            return nil
        }
        
        self.partnerName = partnerName
        self.partnerDiscipline = partnerDiscipline
        
        if let partnerPreviousResponse = arguments[safe: .PartnerPreviousResponse] {
            self.partnerDidConfessPreviously = partnerPreviousResponse == PrisonerConcienceOption.Confess.rawValue
        } else {
            self.partnerDidConfessPreviously = nil
        }

        if let playerPreviousResponse = arguments[safe: .PlayerPreviousResponse] {
            self.playerDidConfessPreviously = playerPreviousResponse == PrisonerConcienceOption.Confess.rawValue
        } else {
            self.playerDidConfessPreviously = nil
        }
    }
}

extension Interrogation: CustomStringConvertible {
    var description: String {
        return "{partnerName: \(self.partnerName), partnerDiscipline: \(self.partnerDiscipline), partnerDidConfessPreviously: \(self.partnerDidConfessPreviously), playerDidConfessPreviously:\(self.playerDidConfessPreviously)}"
    }
}

//MARK: - Interrogation Argument Constants and Related Extentions

enum InterrogationArguments: Int {
    case AppName = 0
    case PartnerName = 1
    case PartnerDiscipline = 2
    case PartnerPreviousResponse = 3
    case PlayerPreviousResponse = 4
}

extension Array {
    subscript (safe index: InterrogationArguments) -> Element? {
        return indices ~= index.rawValue ? self[index.rawValue] : nil
    }
}