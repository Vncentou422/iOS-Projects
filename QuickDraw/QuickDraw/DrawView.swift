//
//  DrawView.swift
//  QuickDraw
//
//  Created by Vincent Ou on 11/18/18.
//  Copyright © 2018 University of Rochester. All rights reserved.
//

import UIKit

protocol DrawViewDelegate: class {
    func updateLines(_ drawView: DrawView, lines: [QDLine])
}

class DrawView: UIView {
    
    weak var delegate: DrawViewDelegate?
    
    var currentLine: QDLine!
    let currentLineColor = UIColor.green
    
    var tint = UIColor.black {
        didSet { self.setNeedsDisplay() }
    }
    var roundBrush = true {
        didSet { self.setNeedsDisplay() }
    }
    var lines: [QDLine]! {
        didSet { self.setNeedsDisplay() }
    }
    
    let lineWidth: CGFloat = 12.0
    
    override func draw(_ rect: CGRect) {
        guard lines != nil else { return }
        
        tint.setStroke()
        for line in lines {
            strokeLine(line)
        }
        
        if currentLine != nil {
            currentLineColor.setStroke()
            strokeLine(currentLine)
        }
    }
    
    // MARK: - Drawing
    
    func strokeLine(_ line: QDLine) {
        
        let path = makeBezierPath(line)
        path.lineWidth = lineWidth
        path.lineCapStyle = roundBrush ? .round : .square
        path.stroke()
    }
    
    func makeBezierPath(_ line: QDLine) -> UIBezierPath {
        
        let path = UIBezierPath()
        for (i, point) in line.points.enumerated() {
            if i > 0 {
                let pt = line.points[i-1]
                path.move(to: pt)
                path.addLine(to: point)
            }
        }
        
        return path
    }

    // MARK: - Touch Handling
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        guard let touch = touches.first else { return }
        
        let location = touch.location(in: self)
        currentLine = QDLine(startingPoint: location)
        setNeedsDisplay()
    }
    
    // MARK: - Touches
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        guard let touch = touches.first else { return }
        
        let location = touch.location(in: self)
        currentLine.addPoint(location)
        
        setNeedsDisplay()
    }
    
    func handleTouchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let location = touch.location(in: self)
        currentLine.addPoint(location)
        lines.append(currentLine)
        
        delegate?.updateLines(self, lines: lines)
        
        currentLine = nil
        
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        handleTouchesEnded(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        handleTouchesEnded(touches, with: event)
    }
    
}
