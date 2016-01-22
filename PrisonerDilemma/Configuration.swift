//
//  Configuration.swift
//  PrisonerDilemma
//
//  Created by Adam Ranfelt on 1/22/16.
//  Copyright © 2016 Ben Dolmar. All rights reserved.
//

import Foundation
import Swinject
import Genome
import FutureKit

class Configuration {
    let container: Container = Container()
    
    init() {
        container.register(NSBundle.self) { _ in
            NSBundle.mainBundle()
        }
        
        container.register(NSURLSession.self) { _ in
            NSURLSession.sharedSession()
        }
        
        container.register(NSURL.self, name: "API_URL") { _ in
            NSURL(scheme: "http", host: "10.10.11.195:9000", path: "/")!
        }
        
        container.register(JailServiceProtocol.self, name: "seeded") { resolver in
            SeedJailService(bundle: resolver.resolve(NSBundle.self)!)
        }
        
        container.register(HTTPService.self) { resolver in
            HTTPService(session: resolver.resolve(NSURLSession.self)!)
        }
        
        container.register(JailServiceProtocol.self, name: "live") { resolver in
            JailService(httpService: resolver.resolve(HTTPService.self)!, apiURL: resolver.resolve(NSURL.self, name: "API_URL")!)
        }
    }
}