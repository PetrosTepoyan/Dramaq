//
//  SummationInRange.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 19/3/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit

class SummationInRange: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var dateFromOutlet: UIDatePicker!
    @IBOutlet weak var dateToOutlet: UIDatePicker!
    @IBOutlet weak var summationLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    let currencies = ["$ - USD", "€ - EUR", "£ - GBP", "₽ - RUB", "֏ - AMD"]
    var chosenCurrency: String? = "$ - USD"
    var exchangeRates: Currency? {
        didSet {
            DispatchQueue.main.async {
                
            }
        }
    }
    @IBAction func dateFeromValueChanged(_ sender: Any) {
        dateToOutlet.minimumDate = dateFromOutlet.date
    }
    
    @IBAction func dateFrom(_ sender: UIDatePicker) {
        displaySum(dateFromOutlet.date, dateToOutlet.date)
        
    }
    
    @IBAction func dateTo(_ sender: UIDatePicker) {
        displaySum(dateFromOutlet.date, dateToOutlet.date)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        
        let service = CurrencyExchange(base: "USD")
        service.getCurrencies {
            currency in
            self.exchangeRates = currency
            print(currency)
            
            
        }
        
        let price_currency = ManagingRealm().retrievePricesWithCurrency()
        
        let pricesExchanged: [Double] = price_currency.map {
            let factor = exchangeRates?.rates[$0.1]
            return $0.0 * (factor ?? 1)
        }
        let pricesSum = pricesExchanged.reduce(0, +)
        print(pricesSum)
        
    }
    
    func displaySum(_ d1: Date, _ d2: Date) {
        guard d1 < d2 else {
            summationLabel.text = "The dates are inputed wrong."
            return
        }
        summationLabel.text = String(CountingUtilities().summation(from: d1, upto: d2)) + String(chosenCurrency![chosenCurrency!.startIndex])
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return currencies[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chosenCurrency = currencies[row]
        
    }
    

}


