//
//  MainViewController.swift
//  Puzzle15
//
//  Created by Виталий Субботин on 14/07/2019.
//  Copyright © 2019 Виталий Субботин. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBAction func startGame(_ sender: UIButton) {
        
        Game.shared.setPuzzleCount(difficulty: Difficulty(tag: sender.tag))
        Game.shared.mixField()
        
        performSegue(withIdentifier: "gameIdentifier", sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
