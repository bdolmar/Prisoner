//
//  PrisonerView.swift
//  PrisonerDilemma
//
//  Created by Ben Dolmar on 1/22/16.
//  Copyright © 2016 Ben Dolmar. All rights reserved.
//

import Cocoa

@IBDesignable
class PrisonerView: NSView {
    let flagLayer = CAShapeLayer()
    var prisoner: Prisoner?

    @IBOutlet var label: NSTextField?
    @IBOutlet var imageView: NSImageView?
    
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
        self.layer?.masksToBounds = true
        self.layer?.backgroundColor = NSColor(calibratedRed: 66/256, green: 36/256, blue: 41/256, alpha: 0.5).CGColor
        
        self.flagLayer.fillColor = NSColor(calibratedRed: 66/256, green: 36/256, blue: 41/256, alpha: 1.0).CGColor
        self.flagLayer.path = NSBezierPath(rect: NSRect(x: 0, y: 0, width: 158.0, height: 32.0)).CGPath(forceClose: false)
        self.layer?.addSublayer(self.flagLayer)
    }
    
    override func layout() {
        super.layout()

        let width: CGFloat = self.bounds.size.width
        let scaledHeight: CGFloat = 32 * width / 158
        
        self.layer?.cornerRadius = 0.5 * width
        
        self.flagLayer.path = NSBezierPath(rect: NSRect(x: 0, y: 0, width: width, height: scaledHeight)).CGPath(forceClose: false)
    }

    func updateView(prisoner: Prisoner) {
        self.imageView?.image = NSImage(named: prisoner.username)
        self.label?.stringValue = prisoner.firstname
        
        let associatedColor = prisoner.discipline.associatedColor()
        self.layer?.backgroundColor = associatedColor.colorWithAlphaComponent(0.5).CGColor
        self.flagLayer.fillColor = associatedColor.CGColor
    }
}
