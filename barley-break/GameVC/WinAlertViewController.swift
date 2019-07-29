//
//  WinningView.swift
//  Puzzle15
//
//  Created by Виталий Субботин on 16/07/2019.
//  Copyright © 2019 Виталий Субботин. All rights reserved.
//

import UIKit

class WinAlertViewController: UIViewController {

    var controller: GameViewController?
    
    private var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Congratulations"
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private var timeLabel: UILabel = {
        let label = UILabel()

        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var restartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Restart", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 1, blue: 0, alpha: 1), for: .highlighted)
        button.addTarget(self, action: #selector(restart), for: .touchUpInside)
        return button
    }()
    
    private var alertView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.layer.shadowOffset = CGSize(width: 10, height: 10)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 20
        view.layer.shadowOpacity = 0.5
        return view
    }()
    
    private var exitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Back to menu", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 1, blue: 0, alpha: 1), for: .highlighted)
        button.addTarget(self, action: #selector(exit), for: .touchUpInside)
        return button
    }()
    
    @objc func restart() {
        self.dismiss(animated: true) {
            if self.controller != nil {
                self.controller!.restartGame()
            }
        }
    }
    
    @objc func exit() {
        self.dismiss(animated: true) {
            if self.controller != nil {
                self.controller!.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func setTimeLabel(withText text: String?) {
        guard let text = text else { return }
        
        self.timeLabel.text = "Your time: " + text
    }
    
    override func viewDidLoad() {
        self.view.addSubview(alertView)
        self.alertView.addSubview(headerLabel)
        self.alertView.addSubview(restartButton)
        self.alertView.addSubview(timeLabel)
        self.alertView.addSubview(exitButton)
        
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.insertSubview(blurEffectView, at: 0)
        
        setConstraints()
    }
    
    
}

//  Constraints
extension WinAlertViewController {
    
    private func setConstraints() {
        alertView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        alertView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
        alertView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50).isActive = true
        alertView.heightAnchor.constraint(equalToConstant: 350).isActive = true
        
        
        headerLabel.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 20).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 20).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -20).isActive = true
        
        timeLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 30).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 20).isActive = true
        timeLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -20).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        restartButton.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 30).isActive = true
        restartButton.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 20).isActive = true
        restartButton.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -20).isActive = true
        restartButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        exitButton.topAnchor.constraint(equalTo: restartButton.bottomAnchor, constant: 30).isActive = true
        exitButton.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 20).isActive = true
        exitButton.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -20).isActive = true
        exitButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
    }
}
