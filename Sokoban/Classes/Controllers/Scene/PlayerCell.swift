//
//  PlayerCell.swift
//  Sokoban
//
//  Created by pasik_01 on 20.01.17.
//
//

import UIKit

class PlayerCell: UIView {

    let images: UIImageView? = nil
    
    func initPlayer() {
        
        let image1 = UIImage(named: "")!
        let image2 = UIImage(named: "")!
        
        images?.animationImages = [image1, image2]
    }
}
