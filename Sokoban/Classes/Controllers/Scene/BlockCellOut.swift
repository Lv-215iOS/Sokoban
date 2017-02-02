//
//  BlockCell.swift
//  Sokoban
//
//  Created by Dmytro on 1/20/17.
//
//

import UIKit

class BlockCellOut: UIView {
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        context!.setFillColor(UIColor.brown.cgColor)
        context?.fill(rect)
        
        drawLine(rect: rect, context: context!, koef: 100, red: 0.33, green: 0.18, blue: 0.07, x: [rect.width/5, rect.width/5], y: [0, rect.height])
        drawLine(rect: rect, context: context!, koef: 100, red: 0.33, green: 0.18, blue: 0.07, x: [2 * rect.width/5, 2 * rect.width/5], y: [0, rect.height])
        drawLine(rect: rect, context: context!, koef: 100, red: 0.33, green: 0.18, blue: 0.07, x: [3 * rect.width/5, 3 * rect.width/5], y: [0, rect.height])
        drawLine(rect: rect, context: context!, koef: 100, red: 0.33, green: 0.18, blue: 0.07, x: [4 * rect.width/5, 4 * rect.width/5], y: [0, rect.height])
        drawLine(rect: rect, context: context!, koef: 12, red: 0.4, green: 0.2, blue: 0, x: [0, rect.width], y: [0, rect.height])
        drawLine(rect: rect, context: context!, koef: 12, red: 0.4, green: 0.2, blue: 0, x: [rect.width, 0], y: [0, rect.height])
        drawLine(rect: rect, context: context!, koef: 12, red: 0.33, green: 0.18, blue: 0.07, x: [0, rect.width, rect.width, 0, 0], y: [0, 0, rect.height, rect.height, 0])
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
