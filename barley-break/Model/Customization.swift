//
//  Customization.swift
//  Puzzle15
//
//  Created by Виталий Субботин on 20/07/2019.
//  Copyright © 2019 Виталий Субботин. All rights reserved.
//

import UIKit

enum Style: String {
    case title = "Only title"
    case image = "Only image"
    case titleAndImage = "Title and image"
    init(style: String) {
        switch style {
        case "Only title":
            self = .title
        case "Only image":
            self = .image
        case "Title and image":
            self = .titleAndImage
        default:
            self = .titleAndImage
        }
    }

}



class Customization {
    
    static var shared = Customization()
    
    var fontSize: Int = 30 
    var backgroundColor: UIColor?
    var backgroungImage: UIImage?
    
    var style: Style = .title
    
    var gameFieldImageString: String = "spider_man"
    
    
    private init() {
        loadCustomization()
    }
    
    private func loadCustomization() {
        let ud = UserDefaults.standard
        
        guard let styleString = ud.string(forKey: "style") else { return }
       
        self.style = Style(style: styleString)
        
        self.fontSize = ud.integer(forKey: "fontSize") == 0 ? 20 : ud.integer(forKey: "fontSize")
       
        if let imageString = ud.string(forKey: "gameFieldImageString") {
            self.gameFieldImageString = imageString
            
        } 
    }
    
    func saveCustomization() {
        let ud = UserDefaults.standard
        ud.set(style.rawValue, forKey: "style")
        ud.set(fontSize, forKey: "fontSize")
        ud.set(gameFieldImageString, forKey: "gameFieldImageString")
        
        
    }
    
    func setFontSize(size: Int) {
        self.fontSize = size
    }
    
    
}
