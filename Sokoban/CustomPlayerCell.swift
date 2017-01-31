//
//  CustomPlayerCell.swift
//  Sokoban
//
//  Created by Oleksiy Bilyi on 1/28/17.
//
//

import UIKit

class CustomPlayerCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var playerScore: UILabel!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerImageView: UIImageView!
    
    // MARK: - Properties
    private let activity = UIActivityIndicatorView()
    
    // MARK: - Cell life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        playerImageView.layer.cornerRadius = 30
        playerImageView.clipsToBounds = true
        activity.alpha = 1
        activity.center = CGPoint(x: 30, y: 30)
        activity.color = UIColor.black
        playerImageView.addSubview(activity)
        activity.startAnimating()
    }
    
    // MARK: - Internal
    /// Remaves activity indicator from playerImageView
    func removeActivityIndicator() {
        activity.removeFromSuperview()
    }

}
