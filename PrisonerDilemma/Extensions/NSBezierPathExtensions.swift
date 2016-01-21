//
//  NSBezierPathExtensions.swift
//  PrisonerDilemma
//
//  Created by Ben Dolmar on 1/21/16.
//  Copyright © 2016 Ben Dolmar. All rights reserved.
//

import Cocoa

extension NSBezierPath {
    // Adapted from : https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/CocoaDrawingGuide/Paths/Paths.html#//apple_ref/doc/uid/TP40003290-CH206-SW2
    // See also: http://www.dreamincode.net/forums/topic/370959-nsbezierpath-to-cgpathref-in-swift/
    func CGPath(forceClose forceClose:Bool) -> CGPathRef? {
        var cgPath:CGPathRef? = nil
        
        let numElements = self.elementCount
        if numElements > 0 {
            let newPath = CGPathCreateMutable()
            let points = NSPointArray.alloc(3)
            var bDidClosePath:Bool = true
            
            for i in 0 ..< numElements {
                
                switch elementAtIndex(i, associatedPoints:points) {
                    
                case NSBezierPathElement.MoveToBezierPathElement:
                    CGPathMoveToPoint(newPath, nil, points[0].x, points[0].y )
                    
                case NSBezierPathElement.LineToBezierPathElement:
                    CGPathAddLineToPoint(newPath, nil, points[0].x, points[0].y )
                    bDidClosePath = false
                    
                case NSBezierPathElement.CurveToBezierPathElement:
                    CGPathAddCurveToPoint(newPath, nil, points[0].x, points[0].y, points[1].x, points[1].y, points[2].x, points[2].y )
                    bDidClosePath = false
                    
                case NSBezierPathElement.ClosePathBezierPathElement:
                    CGPathCloseSubpath(newPath)
                    bDidClosePath = true
                }
                
                if forceClose && !bDidClosePath {
                    CGPathCloseSubpath(newPath)
                }
            }
            cgPath = CGPathCreateCopy(newPath)
        }
        return cgPath
    }
}
