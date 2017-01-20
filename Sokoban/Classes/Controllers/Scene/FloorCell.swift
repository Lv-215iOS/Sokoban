//
//  FloorCell.swift
//  Sokoban
//
//  Created by admin on 1/18/17.
//
//

import UIKit

class FloorCell: UIView {

    override func draw(_ rect: CGRect) {
        // 1. Get CG context
        let context = UIGraphicsGetCurrentContext()
        
        // 2. Draw into context
        context?.setFillColor(UIColor.blue.cgColor)
        context?.fill(rect)
    }
 

}
