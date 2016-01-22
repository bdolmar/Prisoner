//
//  LeaderboardCell.swift
//  PrisonerDilemma
//
//  Created by Ben Dolmar on 1/22/16.
//  Copyright © 2016 Ben Dolmar. All rights reserved.
//

import Cocoa

class LeaderboardCell: NSView {
    
    @IBOutlet var userNameLabel: NSTextField?
    @IBOutlet var disciplineLabel: NSTextField?
    @IBOutlet var sentenceLabel: NSTextField?
    @IBOutlet var prisonerView: PrisonerView?
    
    func updateWithPrisoner(prisoner: Prisoner) {
        self.userNameLabel?.stringValue = prisoner.fullname
        self.disciplineLabel?.stringValue = prisoner.discipline.description()
        self.sentenceLabel?.stringValue = String(prisoner.sentence)
        self.prisonerView?.updateView(prisoner)
        
    }
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        NSColor.blackColor().setFill()
        NSRectFill(NSRect(x: 0, y: 0, width: dirtyRect.width, height: 1))
    }
    
}
