//
//  Player.swift
//  Sokoban
//
//  Created by adminaccount on 1/20/17.
//
//

import UIKit

class Player: UIView {

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.yellow.cgColor)
        context?.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width < rect.height ? rect.width/2 : rect.height/2, startAngle: 0.0, endAngle: 2 * CGFloat.pi, clockwise: false)
        context?.strokePath()
        context?.fillEllipse(in: rect)
        
        context?.setStrokeColor(UIColor.blue.cgColor)
        context?.addArc(center: CGPoint(x: 1.1 * rect.midX/2, y: rect.midY/2), radius: rect.width < rect.height ? 2/3 * rect.width/2 : 2/3 * rect.height/2, startAngle: 0.0, endAngle: 2 * CGFloat.pi, clockwise: false)
        context?.strokePath()
        context?.fillPath()
        
        context?.setStrokeColor(UIColor.blue.cgColor)
        context?.addArc(center: CGPoint(x: 3 * 0.9 * rect.midX/2, y: rect.midY/2), radius: rect.width < rect.height ? 2/3 * rect.width/16 : 2/3 * rect.height/16, startAngle: 0.0, endAngle: 2 * CGFloat.pi, clockwise: false)
        context?.strokePath()
        context?.fillPath()
    }
}
