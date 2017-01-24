//
//  PlayersViewController.swift
//  Sokoban
//
//  Created by pasik_01 on 19.01.17.
//
//

import UIKit

class PlayersViewController: UIViewController {

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        guard let player = PlayersProvider.getPlayers()?[indexPath.row]
             else {
                return cell
        }
        cell.textLabel?.text = player.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "List of Players"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard let playerToRemove = PlayersProvider.getPlayers()?[indexPath.row],
            editingStyle == .delete else {
                return
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
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    }
    
}

