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
    
    func fetchScores() -> Future<NSData> {
        return fetchFileContents()
    }
}