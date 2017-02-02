//
//  LeaderboardViewController.swift
//  Sokoban
//
//  Created by pasik_01 on 19.01.17.
//
//

import UIKit

class LeaderboardViewController: UIViewController {
    
    // MARK: - Properties
    fileprivate let leaderBoardCellIdentifier = "leaderBoardCellReuseIdentifier"
    fileprivate var playersCount = 0
    
     // MARK: - IBOutlets
    @IBOutlet weak var leaderTableView: UITableView!

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let players = PlayersProvider.getPlayers() {
            playersCount = players.count
        }
        
        leaderTableView.dataSource = self
        leaderTableView.tableFooterView = UIView()
        leaderTableView.alwaysBounceVertical = false
    }
}

// MARK: - UITableViewDataSource
extension LeaderboardViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: leaderBoardCellIdentifier, for: indexPath)
        guard let leaderBoardCell = cell as? CustomLeaderBoardCell else {
            return cell
        }
        
        if playersCount <= indexPath.row {
            leaderBoardCell.order.text = String(indexPath.row + 1)
            return leaderBoardCell
        }
        
        let player = PlayersProvider.fetchedResultController.object(at: indexPath)
        
        if let playerScore = player.score,
           let playerPhoto = player.photo {
            leaderBoardCell.playerScore.text = playerScore.stringValue
            leaderBoardCell.playerImageView.image = UIImage(data: playerPhoto)
        }
        leaderBoardCell.playerName.text = player.name
        leaderBoardCell.order.text = String(indexPath.row + 1)
        
        return leaderBoardCell
    }
}


