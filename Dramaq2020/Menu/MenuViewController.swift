//
//  MenuViewController.swift
//  Dramaq
//
//  Created by Петрос Тепоян on 3/3/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit
import AUPickerCell

class MenuViewController: UITableViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func turnOnSoundsSwitcher(_ sender: Any) {
        let switcher = sender as! UISwitch
        UserDefaults.standard.set(switcher.isOn, forKey: "SoundsAreTurnedOn")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath == IndexPath(row: 0, section: 0) {
            let cell = AUPickerCell(type: .default, reuseIdentifier: "CurrencyCell")
            cell.delegate = self
            let currencies = ["$ - USD", "€ - EUR", "£ - GBP", "₽ - RUB", "֏ - AMD"]
            let currentCurrency = (UserDefaults.standard.value(forKey: "CurrentCurrency") ?? "$") as! String
            let selectedCurrency = currencies.firstIndex(of: currentCurrency)
            cell.values = currencies
            cell.selectedRow = selectedCurrency ?? 0
            cell.leftLabel.text = "Currency"
            return cell
        }
        if indexPath == IndexPath(row: 1, section: 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SoundCell", for: indexPath) as! SoundCell
            let isTurned = UserDefaults.standard.value(forKey: "SoundsAreTurnedOn") as? Bool
            cell.soundSwitcherOutlet.isOn = isTurned ?? true
            return cell
            
        }
        if indexPath == IndexPath(row: 2, section: 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UsernameCell", for: indexPath) as! UsernameCell
            let text = UserDefaults.standard.value(forKey: "Username")
            cell.usernameTFOutlet.text = (text as? String ?? "Petros Tepoyan")
            return cell
        }
        else {
            return tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      if let cell = tableView.cellForRow(at: indexPath) as? AUPickerCell {
        return cell.height
      }
      return super.tableView(tableView, heightForRowAt: indexPath)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
      if let cell = tableView.cellForRow(at: indexPath) as? AUPickerCell {
        cell.selectedInTableView(tableView)
      }
    }
    
    
    
    // MARK: - Table view data source
}



extension MenuViewController: AUPickerCellDelegate {
    func auPickerCell(_ cell: AUPickerCell, didPick row: Int, value: Any) {
        UserDefaults.standard.set(value as! String, forKey: "CurrentCurrency")
    }
    

}
