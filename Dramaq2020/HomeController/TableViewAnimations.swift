//
//  TableViewAnimations.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 23/4/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit

extension HomeController {
    func showingRecordsAnimation(){
        let chng1: CGFloat = 100.0
        UIView.animate(
            withDuration: 0.4,
            delay: 0,
            usingSpringWithDamping: 5,
            initialSpringVelocity: 0.3,
            options: .curveEaseInOut,
            animations: {
                self.tableView.frame  = self.tableView.frame.offsetBy(dx: 0, dy: -270)
                self.arrowView.center.y -= 260
                self.arrowView.up()
                self.addARecord.center.x += 110
                self.addARecord.center.y -= 55
                self.incomeButton.center.y -= chng1
                self.analysisButton.center.y -= chng1
                self.accountButton.center.y -= chng1
                self.menuButton.center.y -= chng1
                self.addRecordView.alpha = 0
                self.searchField.center.y -= 290
                self.searchField.center.x -= 70
                
                
                self.view.layoutIfNeeded()
        }, completion: nil )
    }
    
    func hidingRecordsAnimation(){
        let chng1: CGFloat = 100.0
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 5,
            initialSpringVelocity: 0.3,
            options: .curveEaseInOut,
            animations: {
                self.tableView.frame = self.tableView.frame.offsetBy(dx: 0, dy: 270)
                self.arrowView.center.y += 220
                self.arrowView.down()
                self.addARecord.center.x -= 110
                self.addARecord.center.y += 55
                self.incomeButton.center.y += chng1
                self.analysisButton.center.y += chng1
                self.accountButton.center.y += chng1
                self.menuButton.center.y += chng1
                self.addRecordView.alpha = 1
                self.searchField.center.y += 290
                self.searchField.center.x += 70
                
                
                self.view.layoutIfNeeded()
                
        }, completion: {finish in
            self.searchField.endEditing(true)
        }
            
        )
    }
}
