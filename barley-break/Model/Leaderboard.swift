//
//  Leaderboard.swift
//  Puzzle15
//
//  Created by Виталий Субботин on 19/07/2019.
//  Copyright © 2019 Виталий Субботин. All rights reserved.
//

import Foundation

class Leaderboard {
    
//    private var leaderboard: [String] = []
    
    static let shared = Leaderboard()
    
    private init() {
        
    }
    
    func getData(forDifficulty difficulty: Difficulty) -> [String] {
        let ud = UserDefaults.standard
        guard let key = convertDifficultyToString(difficulty: difficulty) else {
            return []
        }
        guard let data = ud.stringArray(forKey: key) else {
            return []
        }
        
        return data
    }
    
    private func saveData(data: [String], forkey key: String?) {
        
        guard let difficultyKey = key else {
            print("key not found while saving")
            return
        }
        
        let ud = UserDefaults.standard
        
        ud.set(data, forKey: difficultyKey)
        ud.synchronize()
        
       
    }
    
    func addValue(record: String?, difficulty: Difficulty) {
        guard let record = record else {
            print("saving error occured")
            return
        }
        var leaderboard = getData(forDifficulty: difficulty)
        leaderboard.append(record)
        leaderboard.sort()
        if leaderboard.count >= 5 {
            leaderboard = Array(leaderboard[0..<5])
        }
        saveData(data: leaderboard, forkey: convertDifficultyToString(difficulty: Game.shared.difficulty))
//        print("data saved: ", leaderboard)
    }
    
    private func convertDifficultyToString(difficulty: Difficulty?) -> String? {
        
        if difficulty == nil {
            return nil
        }

        switch difficulty! {
            
        case .easy:
            return "easy"
        case .medium:
            return "medium"
        case .hard:
            return "hard"
        }
        
    }
}
