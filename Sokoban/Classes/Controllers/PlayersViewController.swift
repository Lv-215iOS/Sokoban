//
//  PlayersViewController.swift
//  Sokoban
//
//  Created by Oleksiy Bilyi on 19.01.17.
//
//

import UIKit

class PlayersViewController: UIViewController {
    
    // MARK: - Properties
    fileprivate let playerCellIdentifier = "playerCellReuseIdentifier"
    fileprivate let playersResultsController = PlayersProvider.fetchedResultController
    /// Index for selected player cell
    var selectedIndex: Int = 1

    // MARK: - IBOutlets
    @IBOutlet weak var playersTableView: UITableView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PlayersProvider.fetchedResultController.delegate = self
        playersTableView.dataSource = self
        playersTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        playersTableView.reloadData()
    }
    
    // MARK: - IBActions
    /// adding player alert appears 
    @IBAction func addNewPlayerButtonTapped(_ sender: UIButton) {
    }
    
}

// MARK: - UITableViewDataSource
extension PlayersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionInfo = PlayersProvider.fetchedResultController.sections?[section] else {
            return 0
        }
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: playerCellIdentifier, for: indexPath)
        guard let playerCell = cell as? CustomPlayerCell else {
            return cell
        }
        let player = PlayersProvider.fetchedResultController.object(at: indexPath)
        // if player in current cell is currentPlayer, check cell
        if player == PlayersProvider.currentPlayer {
            playerCell.accessoryType = .checkmark
            selectedIndex = indexPath.row
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .bottom)
        } else {
            playerCell.accessoryType = .none
        }
        PlayersProvider.asynchGetPhotoForPlayer(player.name!) { (image) in
            DispatchQueue.main.sync {
                playerCell.playerImageView.image = image
                playerCell.removeActivityIndicator()
            }
        }
        playerCell.playerName.text = player.name
        if let playerScore = player.score?.stringValue {
            playerCell.playerScore.text = "score - " + playerScore
        }
        return playerCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let path = IndexPath(row: 0, section: 0)
        guard let playerToRemove = PlayersProvider.getPlayers()?[indexPath.row],
              let firstCell = tableView.cellForRow(at: path),
              let firstCellText = firstCell.textLabel?.text,
              let currentCellText = tableView.cellForRow(at: indexPath)?.textLabel?.text,
              editingStyle == .delete else {
                return
        }
        // If deleting last player in table, present alert
        if tableView.numberOfRows(inSection: 0) == 1 {
            let alert = UIAlertController(title: "Can't delete last user", message: nil, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel, handler: { (action) in })
            alert.addAction(ok)
            present(alert, animated: true)
            return
        }
        if PlayersProvider.currentPlayer?.name == currentCellText {
            firstCell.accessoryType = .checkmark
            PlayersProvider.setCurrentPlayerWith(name: firstCellText)
        }
        PlayersProvider.deletePlayer(playerToRemove)
        playersTableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

// MARK: - UITableViewDelegate
extension PlayersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let currentSelectedCell = tableView.cellForRow(at: indexPath) as? CustomPlayerCell,
              let checkedCell = tableView.cellForRow(at: IndexPath(row: selectedIndex, section: 0)) else {
                return
        }
        currentSelectedCell.accessoryType = .checkmark
        if selectedIndex != indexPath.row {
            checkedCell.accessoryType = .none
        }
        selectedIndex = indexPath.row
        if let currentSelectedPlayerName = currentSelectedCell.playerName.text {
            PlayersProvider.setCurrentPlayerWith(name: currentSelectedPlayerName)
        }
    }
}

// MARK: - NSFetchedResultsControllerDelegate
extension PlayersViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        playersTableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        if type == .update {
            let cell = playersTableView.cellForRow(at: indexPath!) as! CustomPlayerCell
            cell.playerImageView.image = UIImage(data: PlayersProvider.fetchedResultController.object(at: indexPath!).photo!)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        playersTableView.endUpdates()
    }
    
}

