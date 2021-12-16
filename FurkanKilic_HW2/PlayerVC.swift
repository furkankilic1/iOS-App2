//
//  PlayerVC.swift
//  FurkanKilic_HW2
//
//  Created by CTIS Student on 18.11.2021.
//  Copyright © 2021 CTIS. All rights reserved.
//

import UIKit

class PlayerVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mPickerView: UIPickerView!
    @IBOutlet weak var mTableView: UITableView!
    var teamPlayers = [String]()
    var teamMap = [String: String]()
    var teamPlayersInPicker = [String]()
    var getTeam = 0
    var isBesiktasClicked = false
    var isFenerClicked = false
    var isGalatasarayClicked = false
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamPlayers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = teamPlayers[indexPath.row]
        
        let teamImage = UIImage(named: teamMap[teamPlayers[indexPath.row]]!)
        cell.imageView?.image = teamImage
        
        return cell
    }
    
    @IBAction func besiktasClicked(_ sender: Any) {
        fillPicker(team: "besiktas")
        mPickerView.reloadAllComponents()
        if (!isBesiktasClicked) {
            isBesiktasClicked = true
            populateData(team: "besiktas")
            mPickerView.reloadAllComponents()
            mTableView.reloadData()
            getTeam = 0
        }
    }
    
    @IBAction func fenerClicked(_ sender: Any) {
        fillPicker(team: "fenerbahce")
        mPickerView.reloadAllComponents()
        if(!isFenerClicked) {
            isFenerClicked = true
            populateData(team: "fenerbahce")
            mPickerView.reloadAllComponents()
            mTableView.reloadData()
            getTeam = 1
        }
    }
    
    @IBAction func galataClicked(_ sender: Any) {
        fillPicker(team: "galatasaray")
        mPickerView.reloadAllComponents()
        if(!isGalatasarayClicked) {
            isGalatasarayClicked = true
            populateData(team: "galatasaray")
            mTableView.reloadData()
            getTeam = 2
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of items/rows in the components
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return teamPlayersInPicker.count
    }
    
    // Called automatically multiple times. To attach the data
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return teamPlayersInPicker[row]
    }
    
    // Called when an item in pickerView is selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        

    }
    
    func populateData(team: String) {
        if let path = Bundle.main.path(forResource: "players", ofType: "plist") {
            if let dictArray = NSArray(contentsOfFile: path) {
                for item in dictArray {
                    if let dict = item as? NSDictionary {
                        if (dict.allKeys[0] as! String) == team {
                            teamPlayers.append(dict.allValues[0] as! String)
                            teamMap[(dict.allValues[0] as! String)] = team
                        }
                    }
                }
            }
        }
    }
    
    func fillPicker(team: String) {
        teamPlayersInPicker.removeAll()
        if let path = Bundle.main.path(forResource: "players", ofType: "plist") {
            if let dictArray = NSArray(contentsOfFile: path) {
                for item in dictArray {
                    if let dict = item as? NSDictionary {
                        if (dict.allKeys[0] as! String) == team {
                            teamPlayersInPicker.append(dict.allValues[0] as! String)
                        }
                    }
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
