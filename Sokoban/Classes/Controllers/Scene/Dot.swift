//
//  Dot.swift
//  Sokoban
//
//  Created by adminaccount on 1/20/17.
//
//

import UIKit

class Dot: UIView {

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()        
        context?.setFillColor(UIColor.blue.cgColor)
        context?.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width < rect.height ? rect.width/2 : rect.height/2, startAngle: 0.0, endAngle: 2 * CGFloat.pi, clockwise: false)
        context?.strokePath()        
        context?.fillEllipse(in: rect)
    }
}
