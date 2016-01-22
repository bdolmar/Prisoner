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
    private let API_URL: NSURL = NSURL(scheme: "http", host: "10.10.11.195:9000", path: "/")!
    private var httpService: HTTPService
    
    init(httpService: HTTPService) {
        self.httpService = httpService
    }
}

extension JailService : JailServiceProtocol {
    private func buildAPIUrl(part: String) -> NSURL? {
        return NSURL(string: part, relativeToURL: self.API_URL)
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