//
//  SummationInRange.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 19/3/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit

class SummationInRange: UIViewController {

    @IBOutlet weak var dateFromOutlet: UIDatePicker!
    @IBOutlet weak var dateToOutlet: UIDatePicker!
    
    @IBAction func dateFrom(_ sender: UIDatePicker) {
        displaySum(dateFromOutlet.date, dateToOutlet.date)
    }
    
    @IBAction func dateTo(_ sender: UIDatePicker) {
        displaySum(dateFromOutlet.date, dateToOutlet.date)
    }
    
    @IBOutlet weak var summationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func displaySum(_ d1: Date, _ d2: Date) {
        guard d1 < d2 else {
            summationLabel.text = "The dates are inputed wrong."
            return
        }
        summationLabel.text = String(CountingUtilities().summation(from: d1, upto: d2))
    }
    

}
