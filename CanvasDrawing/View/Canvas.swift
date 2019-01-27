//
//  Canvas.swift
//  CanvasDrawing
//
//  Created by SEAN on 2019/1/20.
//  Copyright © 2019 SEAN. All rights reserved.
//

import UIKit

class Canvas: UIView {
    private var lines = [Line]()
    private var strokeColor: UIColor = .black
    private var strokeWidth: CGFloat = 1
    
    func undo() {
        _ = lines.popLast()
        setNeedsDisplay()
    }
    
    func clear() {
        lines.removeAll()
        setNeedsDisplay()
    }
    
    func changeStrokeColor(color: UIColor) {
        strokeColor = color
    }
    
    func changeStrokeWidth(value: CGFloat) {
        strokeWidth = value
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setLineCap(.round)

        lines.forEach { (line) in
            for (index, p) in line.points.enumerated() {
                context.setStrokeColor(line.color)
                context.setLineWidth(line.width)
                
                if index == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
            context.strokePath()
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let line = Line.init(color: strokeColor.cgColor, width: strokeWidth, points: [])
        lines.append(line)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        
        guard var lastLine = lines.popLast() else { return }
        lastLine.points.append(point)
        lines.append(lastLine)
        setNeedsDisplay()
    }
}
