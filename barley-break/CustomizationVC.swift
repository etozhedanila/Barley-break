//
//  CustomizationVC.swift
//  Puzzle15
//
//  Created by Виталий Субботин on 21/07/2019.
//  Copyright © 2019 Виталий Субботин. All rights reserved.
//

import UIKit

class CustomizationViewController: UIViewController {
  
    let headers: [String] = ["Choose the style of game cells", "Choose the font size", "Choose the image for game cells"]
    let images: [String] = ["spider_man", "iron_man"]
    let styles: [String] = ["Only title", "Only image", "Title and image"]
    let fontSizesTitles = ["Small", "Normal", "Big"]
    let fontSizes = [20,30,40]
    var selectedCells = [0,0,0]
    
    func setSelectedCell() {
        selectedCells[0] = styles.firstIndex(of: Customization.shared.style.rawValue)!
        selectedCells[1] = fontSizes.firstIndex(of: Customization.shared.fontSize)!
        selectedCells[2] = images.firstIndex(of: Customization.shared.gameFieldImageString)!
        
    }
    
    
    private var cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        button.setBackgroundImage(UIImage(named: "cancel"), for: .normal)

        return button
    }()
    
    private var saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitle("Save", for: .normal)
        
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)

        return button
    }()
    
    @objc  private func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func saveButtonTapped() {
        
        Customization.shared.style = Style(rawValue: styles[selectedCells[0]])!
        Customization.shared.fontSize = fontSizes[selectedCells[1]]
        Customization.shared.gameFieldImageString = images[selectedCells[2]]
        
        Customization.shared.saveCustomization()
        dismiss(animated: true, completion: nil)
    }
    
    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(cancelButton)
        self.view.addSubview(saveButton)
        self.view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView(frame: .zero)
        
        
        setConstraints()
        
        setSelectedCell()
        
    }
    
    private func setConstraints() {
        
        saveButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 40).isActive = true

        cancelButton.centerYAnchor.constraint(equalTo: saveButton.centerYAnchor, constant: 0).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20).isActive = true
    }
    
}

extension CustomizationViewController: UITableViewDelegate, UITableViewDataSource {
    
   
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return headers[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return styles.count
        case 1:
            return fontSizes.count
        case 2:
            return images.count
        
        default:
            return 0
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if indexPath.section < 2 {
            cell.textLabel?.text = indexPath.section == 0 ? styles[indexPath.row] : fontSizesTitles[indexPath.row]
        }
        else {
            cell.textLabel?.text = images[indexPath.row].replacingOccurrences(of: "_", with: " ").capitalized
            cell.imageView?.image = UIImage(named: images[indexPath.row])
        }
        
        if indexPath.row == selectedCells[indexPath.section] {
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
        }
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedCells[indexPath.section] = indexPath.row
        tableView.reloadData()
    }
    
}
