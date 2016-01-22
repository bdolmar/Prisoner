//
//  JailService.swift
//  PrisonerDilemma
//
//  Created by Adam Ranfelt on 1/21/16.
//  Copyright © 2016 Ben Dolmar. All rights reserved.
//

import Foundation
import Genome
import FutureKit

class JailService {
    private let apiURL: NSURL
    private let httpService: HTTPService
    
    init(httpService: HTTPService, apiURL: NSURL) {
        self.httpService = httpService
        self.apiURL = apiURL
    }
}

extension JailService : JailServiceProtocol {
    private func buildAPIUrl(part: String) -> NSURL? {
        return NSURL(string: part, relativeToURL: self.apiURL)
    }
    
    func fetchScores() -> Void {
        let pipeline = PrisonerSerializationPipeline()
        
        var future = self.httpService.fetchGET(self.buildAPIUrl("scores")!)
            .onComplete { (data) -> Void in
//                let json = pipeline.serialize(data)
//                return json;
        }
    }
}