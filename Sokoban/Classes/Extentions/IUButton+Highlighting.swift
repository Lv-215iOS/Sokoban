//
//  IUButton+Highlighting.swift
//  Sokoban
//
//  Created by Yuriy Lubinets on 1/30/17.
//
//

import Foundation
import UIKit

extension UIButton {
    func highlight(){
        self.alpha = 0.2
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1.0
        })
    }
}
