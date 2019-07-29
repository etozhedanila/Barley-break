//
//  GameView.swift
//  Puzzle15
//
//  Created by Виталий Субботин on 14/07/2019.
//  Copyright © 2019 Виталий Субботин. All rights reserved.
//

import UIKit


class GameView: UIView {
    
    var fieldImages: [UIImage] = []
    
    var controller: GameViewController?
    
    var buttonsCount: Int?
    
    private var cells: [UIButton] = []
    
    private var width: CGFloat {
        get {
            return self.bounds.width / CGFloat(linesCount)
        }
    }
    private var height: CGFloat {
        get {
            return self.bounds.height / CGFloat(linesCount)
        }
    }
    
    private var linesCount: Double {
        get {
            return sqrt(Double(buttonsCount ?? 0))
        }
    }

    func setGameField() {
        guard let buttonsCount = buttonsCount else {
            print("buttonsCount error")
            return
        }
        
        backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        
        for i in 0..<buttonsCount {
            let button = UIButton(type: .custom)
            button.addTarget(self, action: #selector(cellTapped(_:)), for: .touchUpInside)
//            button.addTarget(self, action: #selector(cellTapped(_:)), for: .allTouchEvents)
            
            button.tag = i

            button.setTitle("\(i + 1)", for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Customization.shared.fontSize))
            
            button.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            button.layer.cornerRadius = 10
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.borderWidth = 2
            
            
            self.addSubview(button)
            button.frame = CGRect(x: CGFloat(i % Int(linesCount)) * width + 1 , y: CGFloat(i / Int(linesCount)) * height + 1, width: width - 2, height: height - 2)

            if i == buttonsCount - 1 {
                button.alpha = 0
            }
            else {
                button.alpha = 0.7
            }
            cells.append(button)
        }
        
        guard let fieldImages = configureImages() else { return }
        self.fieldImages = fieldImages
        
    }
    
    func refreshCells(titles: [String]) {
        for (index, button) in cells.enumerated() {
            button.setTitle(titles[index], for: .normal)
            guard let imgIndex = Int(titles[index]) else { return }

            if button.titleLabel?.text == "0" {
                button.alpha = 0
            }
            else {

                if Customization.shared.style == .titleAndImage {
                    button.setBackgroundImage(fieldImages[imgIndex-1], for: .normal)
                }
                if Customization.shared.style == .image {
                    button.setImage(fieldImages[imgIndex-1], for: .normal)
                    
                    
                }
                button.alpha = 0.7
            }
            button.clipsToBounds = true
        }
    }
    
    @objc func cellTapped(_ sender: UIButton) {
        
        controller?.gameCellTapped(sender: sender)
        
    }
    
    private func configureImages() -> [UIImage]? {

        guard let image = UIImage(named: Customization.shared.gameFieldImageString), let buttonsCount = buttonsCount else { return nil }

        
        let width = image.size.width / CGFloat(linesCount)
        let height = image.size.height / CGFloat(linesCount)
        
        var images: [UIImage] = []
        for i in 0..<buttonsCount {
            let rect = CGRect(x: CGFloat(i % Int(linesCount)) * width, y: CGFloat(i / Int(linesCount)) * height, width: width, height: height)
            guard let image = cropImage(inputImage: image, toRect: rect) else { return nil }
            
            images.append(image)
        }
        return images
    }
    
    private func cropImage(inputImage: UIImage, toRect rect: CGRect) -> UIImage? {
        
        guard let cutImageRef = inputImage.cgImage?.cropping(to: rect) else {
            return nil
        }
        
        let croppedImage = UIImage(cgImage: cutImageRef)
        
        return croppedImage
    }
 

}
