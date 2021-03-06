//
//  Dot.swift
//  Sokoban
//
//  Created by Dmytro on 1/20/17.
//
//

import UIKit

class Dot: UIView {
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(UIColor(red:0.00, green:0.50, blue:0.00, alpha:1.0).cgColor)
        context?.fill(rect)
        let path = UIBezierPath(arcCenter: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width < rect.height ? rect.width/4 : rect.height/4, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        UIColor(red:0.07, green:0.29, blue:0.51, alpha:1.0).set()
        path.fill()
    }
}
