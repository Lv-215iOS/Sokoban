//
//  FloorCell.swift
//  Sokoban
//
//  Created by Dmytro on 1/23/17.
//
//

import UIKit

class FloorCell: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        context!.setFillColor(UIColor(red:0.00, green:0.50, blue:0.00, alpha:1.0).cgColor)
        context?.fill(rect)
        
        context?.setLineWidth((rect.width + rect.height)/100)
        context?.setStrokeColor(UIColor(red:0.20, green:0.80, blue:0.20, alpha:1.0).cgColor)
        context?.move(to: CGPoint(x: rect.width/5, y: rect.height/5))
        context?.addLine(to: CGPoint(x: 2 * rect.width/5, y: rect.height/5))
        context?.strokePath()
        
        context?.setLineWidth((rect.width + rect.height)/100)
        context?.setStrokeColor(UIColor(red:0.20, green:0.80, blue:0.20, alpha:1.0).cgColor)
        context?.move(to: CGPoint(x: 3 * rect.width/5, y: rect.height/5))
        context?.addLine(to: CGPoint(x: 4 * rect.width/5, y: rect.height/5))
        context?.strokePath()
        
        context?.setLineWidth((rect.width + rect.height)/100)
        context?.setStrokeColor(UIColor(red:0.20, green:0.80, blue:0.20, alpha:1.0).cgColor)
        context?.move(to: CGPoint(x: 2 * rect.width/5, y: 2 * rect.height/5))
        context?.addLine(to: CGPoint(x: 3 * rect.width/5, y: 2 * rect.height/5))
        context?.strokePath()
        
        context?.setLineWidth((rect.width + rect.height)/100)
        context?.setStrokeColor(UIColor(red:0.20, green:0.80, blue:0.20, alpha:1.0).cgColor)
        context?.move(to: CGPoint(x: rect.width/5, y: 3 * rect.height/5))
        context?.addLine(to: CGPoint(x: 2 * rect.width/5, y: 3 * rect.height/5))
        context?.strokePath()
        
        context?.setLineWidth((rect.width + rect.height)/100)
        context?.setStrokeColor(UIColor(red:0.20, green:0.80, blue:0.20, alpha:1.0).cgColor)
        context?.move(to: CGPoint(x: 3 * rect.width/5, y: 3 * rect.height/5))
        context?.addLine(to: CGPoint(x: 4 * rect.width/5, y: 3 * rect.height/5))
        context?.strokePath()
        
        context?.setLineWidth((rect.width + rect.height)/100)
        context?.setStrokeColor(UIColor(red:0.20, green:0.80, blue:0.20, alpha:1.0).cgColor)
        context?.move(to: CGPoint(x: 2 * rect.width/5, y: 4 * rect.height/5))
        context?.addLine(to: CGPoint(x: 3 * rect.width/5, y: 4 * rect.height/5))
        context?.strokePath()
    }
}
