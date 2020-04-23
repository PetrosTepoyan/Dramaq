//
//  TableViewCellActions.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 23/4/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit

extension HomeController {
        
        func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let delete = deleteAction(at: indexPath)
            delete.backgroundColor = .white
            
            return UISwipeActionsConfiguration(actions: [delete])
        }
        
        func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let edit = editAction(at: indexPath)
            edit.backgroundColor = .white
            
            return UISwipeActionsConfiguration(actions: [edit])
        }
        
        func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
            
            let entry = entries[indexPath.section][indexPath.row]
            
            let action = UIContextualAction(style: .destructive, title: "") { (action, actionView, completion) in
                let id = entry.id!
                
                if entry is Record {
                    try! self.realm.write { self.realm.objects(RealmRecord.self)[id].isDeleted = true }
    //                self.records = records.filter { $0.filter { $0.id != id } }
                } else if entry is Income {
                    try! self.realm.write { self.realm.objects(RealmIncome.self)[id].isDeleted = true }
                }
                
                self.entries[indexPath.section].remove(at: indexPath.row)
                if self.entries[indexPath.section].isEmpty {
                    self.entries.remove(at: indexPath.section)
                }
                
                UIView.transition(with: self.tableView,
                duration: 0.35,
                options: [.curveEaseInOut, .transitionCrossDissolve],
                animations: { self.tableView.reloadData() })
                completion(true)
                
                actionView.backgroundColor = .red
                
                UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: ["EntryNotification.\(id)"])
                
                print("Action view:", actionView)
                
            }
            let image = UIImage(named: "Trash 2-2")
            action.image = image
            action.backgroundColor = .white
            
            
            
            return action
        }
        
        func editAction(at indexPath: IndexPath) -> UIContextualAction {
            let entry = entries[indexPath.section][indexPath.row]
            
            let action = UIContextualAction(style: .normal, title: "") { (action, view, completion) in
                let id = entry.id!
                if let entry = entry as? Record {
                    let childView = self.displayAddRecordChildVC(price: String(entry.price ?? 0.0), place: String(entry.place), category: "\(entry.category)", keywords: entry.keywords)
                    childView.idOfEditingRecord = id
                } else if let entry = entry as? Income{
                    let childView = self.displayAddIncomeChildVC(price: String(entry.price ?? 0.0), source: String(entry.source ?? ""))
                    childView.idOfEditingRecord = id
                }
            }
            let image = UIImage(named: "Edit-2")
            action.image = image
            action.backgroundColor = .white
            
            
            return action
        }
}
