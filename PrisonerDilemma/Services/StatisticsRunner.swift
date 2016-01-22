//
//  StatisticsRunner.swift
//  PrisonerDilemma
//
//  Created by Adam Ranfelt on 1/22/16.
//  Copyright © 2016 Ben Dolmar. All rights reserved.
//

import Foundation
import FutureKit

class StatisticsRunner : NSObject {
    private let jailService: JailServiceProtocol
    private let pipeline: PrisonerSerializationPipeline
    
    private var timer: NSTimer? = nil
    private var isListening: Bool = false
    
    init(jailService: JailServiceProtocol, pipeline: PrisonerSerializationPipeline) {
        self.jailService = jailService
        self.pipeline = pipeline
    }
}

extension StatisticsRunner {
    func startListening() -> Void {
        if self.isListening {
            self.stopListening()
        }
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("step"), userInfo: nil, repeats: true)
        self.isListening = true;
    }
    
    func stopListening() -> Void {
        if !self.isListening {
            return;
        }
        
        self.timer!.invalidate()
        self.isListening = false;
    }
    
    func step() -> Void {
        self.fetchNextStatistics()
            .onSuccess(.Main) { standings -> Void in
                print("step...")
                print(standings)
        }
    }
    
    func fetchNextStatistics() -> Future<CompetitionStandings> {
        return self.jailService.fetchScores()
            .onSuccess(.Main) { data -> Dictionary<String, AnyObject> in
                do {
                    return try self.pipeline.serialize(data)
                } catch {
                    print("Failed to serialize data")
                }
                
                return Dictionary<String, AnyObject>()
            }
            .onSuccess(.Main) { rootDictionary -> CompetitionStandings? in
                do {
                    return try self.pipeline.transform(rootDictionary)
                } catch {
                    print("Failed to transform data")
                }
                
                return nil
            }
            .onSuccess(.Main) { (competitionStandings: CompetitionStandings?) throws -> CompetitionStandings in
                return competitionStandings!
        }
    }
}