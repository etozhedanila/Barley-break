//
//  ViewController.swift
//  Puzzle15
//
//  Created by Виталий Субботин on 14/07/2019.
//  Copyright © 2019 Виталий Субботин. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var time: Int = 0
    var timer: Timer?
    var timeFlag = true
    
    @IBAction func exitButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func mixButtonTapped(_ sender: UIButton) {
        
        restartGame()
    }
    
    func restartGame() {
        gameView.isUserInteractionEnabled = true
        restartTimer()
        Game.shared.mixField()
        refreshGameView()
        
    }

    private var gameView: GameView = GameView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureGameView()
        
        refreshGameView()
        
        createTimer()
    }
    
    private func configureGameView() {
        gameView.frame = CGRect(x: 10, y: self.view.bounds.height / 4 , width: self.view.bounds.width - 20, height: self.view.bounds.width - 20)
        self.view.addSubview(gameView)
        
        gameView.controller = self
        gameView.buttonsCount = Game.shared.puzzlesCount
        gameView.setGameField()
    }
    
    
    func gameCellTapped(sender: UIButton) {
        
        Game.shared.moveCell(position: sender.tag)
        refreshGameView()
        if Game.shared.checkWin() {
            finishGame()
        }
    }
    
    private func finishGame() {
    
        
        Leaderboard.shared.addValue(record: self.timeLabel.text, difficulty: Game.shared.difficulty!)
        gameView.isUserInteractionEnabled = false
        let alert = WinAlertViewController()
        alert.controller = self
        alert.setTimeLabel(withText: self.timeLabel.text)
        alert.modalTransitionStyle = .crossDissolve
        alert.modalPresentationStyle = .overCurrentContext
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            
            self.present(alert, animated: true, completion: nil)
            self.timeFlag = false
        }
        
    }
    
    private func refreshGameView() {
        var titles: [String] = []
        for position in 0..<Game.shared.puzzlesCount {
            let title = "\(Game.shared.getFieldCell(position: position))"
            titles.append(title)
        }
        gameView.refreshCells(titles: titles)
    }

}


//  Working with timer
extension GameViewController {
    
    private func updateTimeTitle() {
        if timeFlag {
            let seconds = time % 60
            let minutes = time / 60
            let minutesLabel = minutes > 9 ? "\(minutes)" : "0\(minutes)"
            let secondsLabel = seconds > 9 ? "\(seconds)" : "0\(seconds)"
            timeLabel.text = minutesLabel + ":" + secondsLabel
        }
        else {
            timeLabel.text = "00:00"
        }
    }
    
    @objc func updateTime() {
        
        time += 1
        updateTimeTitle()
    }
    
    private func createTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        }
    }
    
    private func restartTimer() {
        time = 0
        timeFlag = true
        updateTimeTitle()
    }
    
}

