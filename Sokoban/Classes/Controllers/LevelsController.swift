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
        cell.levelScoreLabel.text = String(levelsScoresArray[indexPath.row])//has to be corrected after we create more levels
        
        return cell
    }
   
    // MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)//highlights for a second
    }

}
