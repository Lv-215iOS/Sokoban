//
//  WallCell.swift
//  Sokoban
//
//  Created by OleksandrYevdokymov on 1/18/17.
//
//

import UIKit

class WallCell: UIView {

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()

        context?.setFillColor(UIColor(red: 0.4392, green: 0.4118, blue: 0.4118, alpha: 1.0).cgColor)
        context?.fill(rect)
        
        context?.setLineWidth((rect.width + rect.height)/100)
        context?.setStrokeColor(UIColor(red: 0.2863, green: 0.0431, blue: 0, alpha: 1.0).cgColor)
        context?.move(to: CGPoint(x: 0, y: 0.04 * rect.height/4))
        context?.addLine(to: CGPoint(x: rect.width, y: 0.04 * rect.height / 4))
        context?.strokePath()
        
        context?.setLineWidth((rect.width + rect.height)/100)
        context?.setStrokeColor(UIColor(red: 0.2863, green: 0.0431, blue: 0, alpha: 1.0).cgColor)
        context?.move(to: CGPoint(x: 0, y: rect.height/4))
        context?.addLine(to: CGPoint(x: rect.width, y: rect.height / 4))
        context?.strokePath()
     
        context?.setLineWidth((rect.width + rect.height)/100)
        context?.setStrokeColor(UIColor(red: 0.2863, green: 0.0431, blue: 0, alpha: 1.0).cgColor)
        context?.move(to: CGPoint(x: 0, y: 2 * rect.height/4))
        context?.addLine(to: CGPoint(x: rect.width, y: 2 * rect.height / 4))
        context?.strokePath()
        
        context?.setLineWidth((rect.width + rect.height)/100)
        context?.setStrokeColor(UIColor(red: 0.2863, green: 0.0431, blue: 0, alpha: 1.0).cgColor)
        context?.move(to: CGPoint(x: 0, y: 3 * rect.height/4))
        context?.addLine(to: CGPoint(x: rect.width, y: 3 * rect.height / 4))
        context?.strokePath()
        
        context?.setLineWidth((rect.width + rect.height)/100)
        context?.setStrokeColor(UIColor(red: 0.2863, green: 0.0431, blue: 0, alpha: 1.0).cgColor)
        context?.move(to: CGPoint(x: rect.width / 2, y: 0))
        context?.addLine(to: CGPoint(x: rect.width / 2, y: rect.height / 4))
        context?.strokePath()
        
        context?.setLineWidth((rect.width + rect.height)/100)
        context?.setStrokeColor(UIColor(red: 0.2863, green: 0.0431, blue: 0, alpha: 1.0).cgColor)
        context?.move(to: CGPoint(x: 0.02 * rect.width / 2, y: 0))
        context?.addLine(to: CGPoint(x: 0.02 * rect.width / 2, y: rect.height / 4))
        context?.strokePath()
        
        context?.setLineWidth((rect.width + rect.height)/100)
        context?.setStrokeColor(UIColor(red: 0.2863, green: 0.0431, blue: 0, alpha: 1.0).cgColor)
        context?.move(to: CGPoint(x: 2.25 * rect.width / 3, y: rect.height / 4))
        context?.addLine(to: CGPoint(x: 2.25 * rect.width / 3, y: 2 * rect.height / 4))
        context?.strokePath()
        
        context?.setLineWidth((rect.width + rect.height)/100)
        context?.setStrokeColor(UIColor(red: 0.2863, green: 0.0431, blue: 0, alpha: 1.0).cgColor)
        context?.move(to: CGPoint(x: 0.75 * rect.width / 3, y: rect.height / 4))
        context?.addLine(to: CGPoint(x: 0.75 * rect.width / 3, y: 2 * rect.height / 4))
        context?.strokePath()
        
        context?.setLineWidth((rect.width + rect.height)/100)
        context?.setStrokeColor(UIColor(red: 0.2863, green: 0.0431, blue: 0, alpha: 1.0).cgColor)
        context?.move(to: CGPoint(x: rect.width / 2, y: 2 * rect.height / 4))
        context?.addLine(to: CGPoint(x: rect.width / 2, y: 3 * rect.height / 4))
        context?.strokePath()
        
        context?.setLineWidth((rect.width + rect.height)/100)
        context?.setStrokeColor(UIColor(red: 0.2863, green: 0.0431, blue: 0, alpha: 1.0).cgColor)
        context?.move(to: CGPoint(x: 0.02 * rect.width / 2, y: 2 * rect.height / 4))
        context?.addLine(to: CGPoint(x: 0.02 * rect.width / 2, y: 3 * rect.height / 4))
        context?.strokePath()
        
        context?.setLineWidth((rect.width + rect.height)/100)
        context?.setStrokeColor(UIColor(red: 0.2863, green: 0.0431, blue: 0, alpha: 1.0).cgColor)
        context?.move(to: CGPoint(x: 2.25 * rect.width / 3, y: 3 * rect.height / 4))
        context?.addLine(to: CGPoint(x: 2.25 * rect.width / 3, y: 4 * rect.height / 4))
        context?.strokePath()
        
        context?.setLineWidth((rect.width + rect.height)/100)
        context?.setStrokeColor(UIColor(red: 0.2863, green: 0.0431, blue: 0, alpha: 1.0).cgColor)
        context?.move(to: CGPoint(x: 0.75 * rect.width / 3, y: 3 * rect.height / 4))
        context?.addLine(to: CGPoint(x: 0.75 * rect.width / 3, y: 4 * rect.height / 4))
        context?.strokePath()

    }

}
