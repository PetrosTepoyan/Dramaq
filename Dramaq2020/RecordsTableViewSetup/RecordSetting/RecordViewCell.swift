//
//  RecordViewCell.swift
//  Dramaq
//
//  Created by Петрос Тепоян on 26/1/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit

class RecordViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    
    func setRecordView(record: RecordView) {
        
        for i in view.subviews{
            i.removeFromSuperview()
        }
        
        view.addSubview(record)
        record.frame = CGRect(x: 5, y: 5, width: view.frame.width - 10, height: 60)

    }
    
    func setIncomeView(income: IncomeView) {
        for i in view.subviews{
            i.removeFromSuperview()
        }
        
        view.addSubview(income)
        income.frame = CGRect(x: 0, y: 5, width: view.frame.width , height: 60)
    }
    
    func setEntryView(entry: EntryView) {
        for i in view.subviews{
            i.removeFromSuperview()
        }
        
        view.addSubview(entry)
        if entry is RecordView {
            entry.frame = CGRect(x: 5, y: 5, width: view.frame.width - 10, height: 60)
        } else {
            entry.frame = CGRect(x: 0, y: 5, width: view.frame.width , height: 60)
        }
        
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.isHidden = true
    }
    
}
