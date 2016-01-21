//
//  AppDelegate.swift
//  PrisonerDilemma
//
//  Created by Ben Dolmar on 12/25/15.
//  Copyright © 2015 Ben Dolmar. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        
        let arenaPath = NSUserDefaults.standardUserDefaults().stringForKey("com.nerdery.arenaPath") ?? NSProcessInfo.processInfo().arguments[0]
        print("arenaPath: \(arenaPath)")
//        print("environment: \(NSProcessInfo.processInfo().environment)")
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}
