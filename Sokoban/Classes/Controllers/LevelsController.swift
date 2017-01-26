//
//  LevelsController.swift
//  Sokoban
//
//  Created by admin on 1/18/17.
//
//

import UIKit

class LevelsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var levelsTableView: UITableView!
    
    var levelsScoresArray = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let levelsScoresData = PlayersProvider.currentPlayer?.levelsScores
        levelsScoresArray = NSKeyedUnarchiver.unarchiveObject(with: levelsScoresData!) as! Array
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let levels = LevelsProvider.getLevels() else {
            return 1
        }
        return levels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "levelsTableViewCell", for: indexPath) as! CustomLevelsTableViewCell
        
        guard let level = LevelsProvider.getLevels()?[indexPath.row]
            else {
                return cell
        }
        
        cell.levelNameLabel.text = level.name
        
        if indexPath.row < levelsScoresArray.count {
            let levelScore = levelsScoresArray[indexPath.row]
            cell.levelScoreLabel.text = String(describing: levelScore)
        } else {
            cell.levelScoreLabel.text = "0.0"
        }
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)//highlights for a second
        
        let chosenLevel = LevelsProvider.getLevels()?[indexPath.row]
        
        performSegue(withIdentifier: "segueToPlaygroundVC", sender: chosenLevel)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueToPlaygroundVC" {
            
            let playgroundController: PlaygroundController = (segue.destination as? PlaygroundController)!
            let chosenLevel = sender as? Level
            playgroundController.currentLevel = chosenLevel
            print(chosenLevel?.name ?? "error")
            
        }
    }
    
}
