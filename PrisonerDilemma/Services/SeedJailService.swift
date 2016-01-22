//
//  JailService.swift
//  PrisonerDilemma
//
//  Created by Adam Ranfelt on 1/21/16.
//  Copyright © 2016 Ben Dolmar. All rights reserved.
//

import Foundation
import FutureKit

class SeedJailService {
    let bundle: NSBundle
    
    init(bundle: NSBundle) {
        self.bundle = bundle
    }
}

extension SeedJailService : JailServiceProtocol {
    private func fetchFileContents() -> Future<NSData> {
        let promise = Promise<NSData>()
        
        let URL = self.bundle.URLForResource("prisoners", withExtension: "json")
        let contents = NSData.init(contentsOfURL: URL!)
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            promise.completeWithSuccess(contents!)
        })
        
        return promise.future
    }
    
    func fetchScores() -> Void {
        let pipeline = PrisonerSerializationPipeline()
        fetchFileContents()
            .onSuccess(.Main) { data -> Dictionary<String, AnyObject> in
                do {
                    return try pipeline.serialize(data)
                } catch {
                    print("Failed to serialize data")
                }
                
                return Dictionary<String, AnyObject>()
        }
            .onSuccess(.Main) { rootDictionary -> CompetitionStandings? in
                do {
                    return try pipeline.transform(rootDictionary)
                } catch {
                    print("Failed to transform data")
                }
                
                return nil
        }
            .onSuccess(.Main) { competitionStandings -> Void in
                print(competitionStandings)
        }
        
    }
}