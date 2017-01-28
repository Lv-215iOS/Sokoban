//
//  CustomPlayerCell.swift
//  Sokoban
//
//  Created by Oleksiy Bilyi on 1/28/17.
//
//

import UIKit

extension UIImage {
    static func fromColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}

class CustomPlayerCell: UITableViewCell {

    @IBOutlet weak var playerScore: UILabel!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        playerImageView.layer.cornerRadius = 30
        playerImageView.clipsToBounds = true
        playerImageView.image = UIImage(cgImage: UIImage.fromColor(color: .black).cgImage!)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
