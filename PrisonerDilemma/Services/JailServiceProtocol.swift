//
//  JailServiceProtocol.swift
//  PrisonerDilemma
//
//  Created by Adam Ranfelt on 1/21/16.
//  Copyright © 2016 Ben Dolmar. All rights reserved.
//

import Foundation
import FutureKit

protocol JailServiceProtocol {
    func fetchScores() -> Void
}