//
//  HTTPService.swift
//  PrisonerDilemma
//
//  Created by Adam Ranfelt on 1/21/16.
//  Copyright © 2016 Ben Dolmar. All rights reserved.
//

import Foundation
import FutureKit

class HTTPService {
    let session: NSURLSession = NSURLSession.sharedSession()
}

extension HTTPService {
    func fetchGET(URL: NSURL) -> Future<NSData> {
        let promise = Promise<NSData>()
        
        let request = NSMutableURLRequest(URL: URL)
        let task = self.session.dataTaskWithRequest(request) {
            
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if error != nil {
                promise.completeWithFail(error!.localizedDescription)
            } else {
                promise.completeWithSuccess(data!)
            }
            
        }
        task.resume()
        
        return promise.future
    }
}