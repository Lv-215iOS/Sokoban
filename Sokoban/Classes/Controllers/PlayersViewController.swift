//
//  PlayersViewController.swift
//  Sokoban
//
//  Created by Oleksiy Bilyi on 19.01.17.
//
//

import UIKit

class PlayersViewController: UIViewController {
    
    /// Index for selected player cell
    var selectedIndex: Int = 1

    @IBOutlet weak var playersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playersTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        playersTableView.dataSource = self
        playersTableView.delegate = self
    }
    
    /// adding player alert appears 
    @IBAction func addNewPlayerButtonTapped(_ sender: UIButton) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        playersTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension PlayersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let players = PlayersProvider.getPlayers() else {
            return 1
        }
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        guard let player = PlayersProvider.getPlayers()?[indexPath.row],
              let cellTextLabel = cell.textLabel,
              let cellDetailTextLabel = cell.detailTextLabel else {
                return cell
        }
        // if player in current cell is currentPlayer, check cell
        if player == PlayersProvider.currentPlayer {
            cell.accessoryType = .checkmark
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .bottom)
        } else {
            cell.accessoryType = .none
        }
        cellTextLabel.text = player.name
        cellDetailTextLabel.text = "score - " + (player.score?.stringValue)!
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let path = IndexPath(row: 0, section: 0)
        guard let playerToRemove = PlayersProvider.getPlayers()?[indexPath.row],
              let cell = tableView.cellForRow(at: path),
              let cellText = cell.textLabel?.text,
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
        PlayersProvider.deletePlayer(playerToRemove)
        playersTableView.deleteRows(at: [indexPath], with: .automatic)
        cell.accessoryType = .checkmark
        PlayersProvider.setCurrentPlayerWith(name: cellText)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

// MARK: - UITableViewDelegate
extension PlayersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cellText = tableView.cellForRow(at: indexPath)?.textLabel?.text else {
                return
        }
        selectedIndex = indexPath.row
        tableView.reloadData()
        PlayersProvider.setCurrentPlayerWith(name: cellText)
    }
}

