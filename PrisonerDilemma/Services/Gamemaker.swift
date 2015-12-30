//
//  GameMaker.swift
//  PrisonerDilemma
//
//  Created by Ben Dolmar on 12/28/15.
//  Copyright © 2015 Ben Dolmar. All rights reserved.
//

import Foundation
import Genome

class Gamemaker {
    var prisonerURL: NSURL = NSURL()

}

//MARK: - Prisoner Loading and Parsing

extension Gamemaker {
    func preparePrisonerData() throws -> [Prisoner] {
        let prisonerJSON = try loadPrisonerJSON()
        return try marshallPrisoners(prisonerJSON)
    }
    
    func loadPrisonerJSON() throws -> JSON {
        if self.prisonerURL.isFileReferenceURL() {
            let data = try NSData(contentsOfURL: self.prisonerURL, options: NSDataReadingOptions.DataReadingMappedIfSafe)
            let parsedJSON = try NSJSONSerialization.JSONObjectWithData(data, options: [])
            if let validatedJSON = parsedJSON as? JSON {
                return validatedJSON
            } else {
                throw GamemakerErrors.InvalidPrisonerJSON
            }
        } else {
            throw GamemakerErrors.InvalidPrisonerURL
        }
    }
    
    func marshallPrisoners(json: JSON) throws -> [Prisoner] {
        guard let prisonersJSON = json["prisoner"] as? [JSON] else {
            throw GamemakerErrors.InvalidPrisonerJSON
        }
        
        var prisoners = [Prisoner]()
        for prisonerJSON in prisonersJSON {
            let prisoner = try Prisoner.mappedInstance(prisonerJSON)
            prisoners.append(prisoner)
        }
        
        return prisoners
    }
}

enum GamemakerErrors: ErrorType {
    case InvalidPrisonerJSON
    case InvalidPrisonerURL
}