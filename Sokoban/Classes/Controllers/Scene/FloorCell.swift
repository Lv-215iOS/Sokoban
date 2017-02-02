//
//  FloorCell.swift
//  Sokoban
//
//  Created by Dmytro on 1/23/17.
//
//

import UIKit

class FloorCell: UIView {
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        context!.setFillColor(UIColor(red:0.00, green:0.50, blue:0.00, alpha:1.0).cgColor)
        context?.fill(rect)
        
        drawLine(rect: rect, context: context!, koef: 100, red: 0.2, green: 0.8, blue: 0.2, x: [rect.width/5, 2 * rect.width/5], y: [rect.height/5, rect.height/5])
        drawLine(rect: rect, context: context!, koef: 100, red: 0.2, green: 0.8, blue: 0.2, x: [3 * rect.width/5, 4 * rect.width/5], y: [rect.height/5, rect.height/5])
        drawLine(rect: rect, context: context!, koef: 100, red: 0.2, green: 0.8, blue: 0.2, x: [2 * rect.width/5, 3 * rect.width/5], y: [2 * rect.height/5, 2 * rect.height/5])
        drawLine(rect: rect, context: context!, koef: 100, red: 0.2, green: 0.8, blue: 0.2, x: [rect.width/5, 2 * rect.width/5], y: [3 * rect.height/5, 3 * rect.height/5])
        drawLine(rect: rect, context: context!, koef: 100, red: 0.2, green: 0.8, blue: 0.2, x: [3 * rect.width/5, 4 * rect.width/5], y: [3 * rect.height/5, 3 * rect.height/5])
        drawLine(rect: rect, context: context!, koef: 100, red: 0.2, green: 0.8, blue: 0.2, x: [2 * rect.width/5, 3 * rect.width/5], y: [4 * rect.height/5, 4 * rect.height/5])
    }
    
    func drawLine(rect: CGRect, context: CGContext, koef: CGFloat, red: CGFloat, green: CGFloat, blue: CGFloat, x: [CGFloat], y: [CGFloat]) {
        context.setLineWidth((rect.width + rect.height)/koef)
        context.setStrokeColor(UIColor(red: red, green: green, blue: blue, alpha: 1.0).cgColor)
        context.move(to: CGPoint(x: x[0], y: y[0]))
        for i in 1..<x.count {
            context.addLine(to: CGPoint(x: x[i], y: y[i]))
        }
        context.strokePath()
    }
}
