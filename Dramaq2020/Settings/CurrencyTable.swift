//
//  CurrencyTable.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 8/3/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit

class CurrencyTable: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var currencyPV: UIPickerView!
    var currency = ["$ - USD", "¥", ]
    var indexesNeedPicker: [NSIndexPath]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPV.delegate = self
        currencyPV.dataSource = self
    }

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        currency.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        print(component)
        return component
        
    }
    
    
    
    // MARK: - Table view data source

}
