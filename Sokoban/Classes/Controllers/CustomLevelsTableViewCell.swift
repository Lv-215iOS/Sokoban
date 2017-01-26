//
//  CustomLevelsTableViewCell.swift
//  Sokoban
//
//  Created by AdminAccount on 1/24/17.
//
//

import UIKit

class CustomLevelsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var levelNameLabel: UILabel!
    
    @IBOutlet weak var levelScoreLabel: UILabel!
    
    @IBOutlet weak var levelStateImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
