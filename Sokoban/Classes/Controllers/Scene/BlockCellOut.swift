//
//  BlockCell.swift
//  Sokoban
//
//  Created by Dmytro on 1/20/17.
//
//

import UIKit

class BlockCellOut: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        context!.setFillColor(UIColor.brown.cgColor)
        context?.fill(rect)
        
        context?.setLineWidth((rect.width + rect.height)/100)
        context?.setStrokeColor(UIColor(red:0.33, green:0.18, blue:0.07, alpha:1.0).cgColor)
        context?.move(to: CGPoint(x: rect.width/5, y: 0))
        context?.addLine(to: CGPoint(x: rect.width/5, y: rect.height))
        context?.strokePath()
        
        context?.setLineWidth((rect.width + rect.height)/100)
        context?.setStrokeColor(UIColor(red:0.33, green:0.18, blue:0.07, alpha:1.0).cgColor)
        context?.move(to: CGPoint(x: 2 * rect.width/5, y: 0))
        context?.addLine(to: CGPoint(x: 2 * rect.width/5, y: rect.height))
        context?.strokePath()
        
        context?.setLineWidth((rect.width + rect.height)/100)
        context?.setStrokeColor(UIColor(red:0.33, green:0.18, blue:0.07, alpha:1.0).cgColor)
        context?.move(to: CGPoint(x: 3 * rect.width/5, y: 0))
        context?.addLine(to: CGPoint(x: 3 * rect.width/5, y: rect.height))
        context?.strokePath()
        
        context?.setLineWidth((rect.width + rect.height)/100)
        context?.setStrokeColor(UIColor(red:0.33, green:0.18, blue:0.07, alpha:1.0).cgColor)
        context?.move(to: CGPoint(x: 4 * rect.width/5, y: 0))
        context?.addLine(to: CGPoint(x: 4 * rect.width/5, y: rect.height))
        context?.strokePath()
        
        context?.setLineWidth((rect.width + rect.height)/12)
        context?.setStrokeColor(UIColor(red:0.40, green:0.20, blue:0.00, alpha:1.0).cgColor)
        context?.move(to: CGPoint(x: 0, y: 0))
        context?.addLine(to: CGPoint(x: rect.width, y: rect.height))
        context?.strokePath()
        
        context?.setLineWidth((rect.width + rect.height)/12)
        context?.setStrokeColor(UIColor(red:0.40, green:0.20, blue:0.00, alpha:1.0).cgColor)
        context?.move(to: CGPoint(x: rect.width, y: 0))
        context?.addLine(to: CGPoint(x: 0, y: rect.height))
        context?.strokePath()
        
        context?.setLineWidth((rect.width + rect.height)/12)
        context?.setStrokeColor(UIColor(red:0.33, green:0.18, blue:0.07, alpha:1.0).cgColor)
        context?.move(to: CGPoint(x: 0, y: 0))
        context?.addLine(to: CGPoint(x: rect.width, y: 0))
        context?.addLine(to: CGPoint(x: rect.width, y: rect.height))
        context?.addLine(to: CGPoint(x: 0, y: rect.height))
        context?.addLine(to: CGPoint(x: 0, y: 0))
        context?.strokePath()
    }
}
