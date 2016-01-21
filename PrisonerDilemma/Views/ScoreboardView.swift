//
//  Scoreboard.swift
//  PrisonerDilemma
//
//  Created by Ben Dolmar on 1/21/16.
//  Copyright © 2016 Ben Dolmar. All rights reserved.
//

import Cocoa

@IBDesignable
class ScoreboardView: NSView {
    let player1Background: CAShapeLayer = CAShapeLayer()
    let player2Background: CAShapeLayer = CAShapeLayer()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        commonSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonSetup()
    }
    
    func commonSetup() {
        self.wantsLayer = true
        
        self.layer?.backgroundColor = NSColor(calibratedRed: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).CGColor
        
        self.player1Background.fillColor = NSColor(calibratedRed: 42/256, green: 135/256, blue: 111/256, alpha: 1.0).CGColor
        self.player1Background.path = NSBezierPath(ovalInRect: NSRect(x: 0, y: 0, width: 480, height: 480)).CGPath(forceClose: false)
        self.layer?.addSublayer(self.player1Background)
        
        self.player2Background.fillColor = NSColor(calibratedRed: 66/256, green: 36/256, blue: 41/256, alpha: 1.0).CGColor
        self.player2Background.path = NSBezierPath(ovalInRect: NSRect(x: 0, y: 0, width: 480, height: 480)).CGPath(forceClose: false)
        self.layer?.addSublayer(self.player2Background)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layout() {
        super.layout()
        let width: CGFloat = self.bounds.size.width
        let scale: CGFloat = 640/480
        let oval = NSBezierPath(ovalInRect: NSRect(x: 0, y: 0, width: width*scale, height: width*scale))
        
        self.player1Background.path = oval.CGPath(forceClose: false)
        self.player2Background.path = oval.CGPath(forceClose: false)

        
    }
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }
    
}
