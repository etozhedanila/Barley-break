//
//  LeaderboardViewController.swift
//  Puzzle15
//
//  Created by Виталий Субботин on 19/07/2019.
//  Copyright © 2019 Виталий Субботин. All rights reserved.
//

import UIKit

class LeaderboardViewController: UIViewController {
    
    var easyLeaderboard: [String] = []
    var mediumLeaderboard: [String] = []
    var hardLeaderboard: [String] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillLeaderboardArrays()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.allowsSelection = false
        
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    @IBAction func exitButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    private func fillLeaderboardArrays() {
        easyLeaderboard = Leaderboard.shared.getData(forDifficulty: .easy)
        mediumLeaderboard = Leaderboard.shared.getData(forDifficulty: .medium)
        hardLeaderboard = Leaderboard.shared.getData(forDifficulty: .hard)
        
    }
}

extension LeaderboardViewController: UITableViewDelegate, UITableViewDataSource {
    

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return  "EASY"
        case 1:
            return "MEDIUM"
        default:
            return "HARD"
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return easyLeaderboard.count
        case 1:

            return mediumLeaderboard.count
        case 2:
            return hardLeaderboard.count
        default:
            return 0
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = easyLeaderboard[indexPath.row]
        case 1:
            cell.textLabel?.text = mediumLeaderboard[indexPath.row]
        case 2:
            cell.textLabel?.text = hardLeaderboard[indexPath.row]
        default:
            break
        }
        return cell
    }
    
    
    
}
