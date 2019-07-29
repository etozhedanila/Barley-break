//
//  GameModel.swift
//  Puzzle15
//
//  Created by Виталий Субботин on 14/07/2019.
//  Copyright © 2019 Виталий Субботин. All rights reserved.
//

import Foundation

enum Difficulty {
    case easy
    case medium
    case hard
    init(tag: Int) {
        switch tag {
        case 0:
            self = .easy
        case 1:
            self = .medium
        case 2:
            self = .hard
            
        default:
            self = .medium
        }
    }
}

class Game {
    var puzzlesCount: Int = 0
    private var fieldSize: Int = 0
    private var emptyX: Int = 0, emptyY: Int = 0
    var difficulty: Difficulty?
    
    
    private var field: [[Int]] = []
    
    static let shared = Game()
    
    private init() {
        
    }
    
    func setPuzzleCount(difficulty: Difficulty) {
        self.difficulty = difficulty
        switch difficulty {
        case .easy:
            self.puzzlesCount = 9
            self.fieldSize = 3
        case .medium:
            self.puzzlesCount = 16
            self.fieldSize = 4
        case .hard:
            self.puzzlesCount = 25
            self.fieldSize = 5
        }
        configureField()
    }
    
    private func configureField() {
        
        field = []
        for x in 0..<fieldSize {
            var row: [Int] = []
            for y in 0..<fieldSize {
                row.append(getPosition(x: x, y: y) + 1)
            }
            field.append(row)
        }
        field[fieldSize - 1][fieldSize - 1] = 0
        emptyX = fieldSize - 1
        emptyY = fieldSize - 1
    }
    
    private func getPosition(x: Int, y: Int) -> Int {
        var tmpX = x, tmpY = y
        if x < 0 { tmpX = 0 }
        if x > fieldSize - 1 { tmpX  = fieldSize - 1 }
        if y < 0 { tmpY  = 0 }
        if y > fieldSize - 1 { tmpY = fieldSize - 1 }
        return tmpY *  fieldSize + tmpX
    }
    
    private func getX(position: Int) -> Int {
        var tmpPosition = position
        if position < 0 { tmpPosition = 0 }
        if position > puzzlesCount - 1 { tmpPosition = fieldSize - 1 }
        return tmpPosition % fieldSize
    }
    
    private func getY(position: Int) -> Int {
        var tmpPosition = position
        if position < 0 { tmpPosition = 0 }
        if position > puzzlesCount - 1 { tmpPosition = fieldSize - 1 }
        return tmpPosition / fieldSize
    }
    
    func getFieldCell(position: Int) -> Int {
        return field[getX(position: position)][getY(position: position)]
    }
    
    func moveCell(position: Int) {
        let x = getX(position: position)
        let y = getY(position: position)
        if (abs(x - emptyX) == 1 && y == emptyY) || (abs(y - emptyY) == 1 && x == emptyX) {
            field[emptyX][emptyY] = field[x][y]
            field[x][y] = 0
            emptyX = x
            emptyY = y
        }
    }
    
    private func moveRandom() {
        var x = emptyX
        var y = emptyY
        let randNumber = Int.random(in: 0...3)
        switch randNumber {
        case 0:
            x -= 1
        case 1:
            x += 1
        case 2:
            y -= 1
        case 3:
            y += 1
        default:
            break
        }
        moveCell(position: getPosition(x: x, y: y))
    }
    
    func mixField() {
        for _ in 0..<1000 {
            moveRandom()
        }
    }
    
    func checkWin() -> Bool {
        
        for x in 0..<fieldSize {
            for y in 0..<fieldSize {
                if x == fieldSize - 1 && y == fieldSize - 1 { return true }
                if field[x][y] != getPosition(x: x, y: y) + 1 { return false }
                
            }
        }
        return true
    }
    
}
