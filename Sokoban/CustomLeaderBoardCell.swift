//
//  CustomLeaderBoardCell.swift
//  Sokoban
//
//  Created by Oleksiy Bilyi on 1/31/17.
//
//

import UIKit

class CustomLeaderBoardCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var order: UILabel!
    @IBOutlet weak var playerScore: UILabel!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerImageView: UIImageView!
    
    // MARK: - Cell life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        playerImageView.layer.cornerRadius = 30
        playerImageView.clipsToBounds = true
    }
    
}
