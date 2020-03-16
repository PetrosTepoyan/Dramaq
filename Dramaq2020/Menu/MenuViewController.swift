//
//  MenuViewController.swift
//  Dramaq
//
//  Created by Петрос Тепоян on 3/3/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController{
    
    let currencyPicker = UIPickerView()
    let currencyPickerData = ["£", "$"]
    let rows = ["Currency"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.delegate   = self
        currencyPicker.dataSource = self
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rows.count
    }

//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuViewCell
//        
//        cell.view.addSubview(currencyPicker)
//        return cell
//    }
    
    
}

extension MenuViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return currencyPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyPickerData[row]
    }
}
