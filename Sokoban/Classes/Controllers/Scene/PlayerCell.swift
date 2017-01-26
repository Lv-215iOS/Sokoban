//
//  PlayerCell.swift
//  Sokoban
//
//  Created by pasik_01 on 20.01.17.
//
//

import UIKit

class PlayerCell: UIImage {
    var imageListRight = [UIImage]()
    var imageListLeft = [UIImage]()
    var imageListUp = [UIImage]()
    var imageListDown = [UIImage]()
        
    func initPlayer() {
        for i in 1...5 {
            imageListRight.append(UIImage(named: "right\(i).png")!)
            imageListLeft.append(UIImage(named: "left\(i).png")!)
            imageListUp.append(UIImage(named: "up\(i).png")!)
            imageListDown.append(UIImage(named: "down\(i).png")!)
        }
    }
}
