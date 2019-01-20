//
//  Canvas.swift
//  CanvasDrawing
//
//  Created by SEAN on 2019/1/20.
//  Copyright © 2019 SEAN. All rights reserved.
//

import UIKit

class Canvas: UIView {
    private var lines = [[CGPoint]]()
    
    func undo() {
        _ = lines.popLast()
        setNeedsDisplay()
    }
    
    func clear() {
        lines.removeAll()
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setLineCap(.round)
        context.setStrokeColor(UIColor.blue.cgColor)
        context.setLineWidth(8)
        
        lines.forEach { (line) in
            for (index, p) in line.enumerated() {
                if index == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
        }
        
        context.strokePath()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]())
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        
        guard var lastLine = lines.popLast() else { return }
        lastLine.append(point)
        lines.append(lastLine)
        setNeedsDisplay()
    }
}
