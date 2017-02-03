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
    
    var builder = SceneBuilder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let levelsScoresData = PlayersProvider.currentPlayer?.levelsScores
        levelsScoresArray = NSKeyedUnarchiver.unarchiveObject(with: levelsScoresData!) as! Array
    }
//    override func viewDidAppear(_ animated: Bool) {
//        
//        super.viewDidAppear(false)
//        levelsTableView.reloadData()
//        
//    }
    
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
        
        //--------------------------------------------
        //Snapshot:
        
        let view = self.builder.getSceneCanvas(level: level)
        let image = UIImage(view: view)
        
        cell.levelSnapshotImage.image = image
        
        //--------------------------------------------
        
        
        if indexPath.row < levelsScoresArray.count {//level score in levelScoreLabel
            let levelScore = levelsScoresArray[indexPath.row]
            cell.levelScoreLabel.text = String(describing: String(format: "%.2f",  levelScore))
            if levelScore > 0.0 {//sets correct levelStateImage
                cell.levelStateImage.image = UIImage(named: "levelPassedImage")
                cell.levelScoreLabel.textColor = UIColor.yellow
            } else if levelScore == 0.0 {//sets correct levelStateImage
                cell.levelScoreLabel.text = "Untried"
                cell.levelStateImage.image = UIImage(named: "levelNotPassedImage")
            }
        } else {
            cell.levelScoreLabel.text = "Untried"
            cell.levelStateImage.image = UIImage(named: "levelNotPassedImage")
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
    @IBAction func unwindToLevel(segue: UIStoryboardSegue) {
        
    }
    
}


