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
    
    @IBOutlet var player1TermTextField: NSTextField!
    @IBOutlet var player2TermTextField: NSTextField!
    @IBOutlet var player1PrisonerView: PrisonerView!
    @IBOutlet var player2PrisonerView: PrisonerView!
    @IBOutlet var roundTextField: NSTextField!
    
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
    
    override func layout() {
        super.layout()
        let width: CGFloat = self.bounds.size.width
        let scale: CGFloat = 640/480
        let scaledSide: CGFloat = width * scale
        let centerX: CGFloat = (width - scaledSide) * 0.5
        let player1Y: CGFloat = width - (1 - 0.784375) * scaledSide
        let player2Y: CGFloat = scaledSide * -0.784375
        let oval1 = NSBezierPath(ovalInRect: NSRect(x: centerX, y: player1Y, width: scaledSide, height: scaledSide))
        let oval2 = NSBezierPath(ovalInRect: NSRect(x: centerX, y: player2Y, width: scaledSide, height: scaledSide))
        
        self.player1Background.path = oval1.CGPath(forceClose: false)
        self.player2Background.path = oval2.CGPath(forceClose: false)
    }
    
    func updateWithRound(round: CompetitionRound) {
        self.player1TermTextField.stringValue = String(round.player1.sentence)
        self.player1PrisonerView.updateView(round.player1)
        self.player1Background.fillColor = round.player1.discipline.associatedColor().CGColor

        self.player2TermTextField.stringValue = String(round.player2.sentence)
        self.player2PrisonerView.updateView(round.player2)
        self.player2Background.fillColor = round.player2.discipline.associatedColor().CGColor
        
        self.roundTextField.stringValue = "Round \(round.roundNumber)"
    }
}
