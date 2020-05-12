//
//  AddRecordChildVC+Collection.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 19/3/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import Foundation
import UIKit
extension AddRecordChildVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView {
            return categoriesInCollection.count
        } else {
            return suggestedKeywords.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView {
            let cell = categoryCollectionView
                .dequeueReusableCell(withReuseIdentifier: "CategoryViewCollectionCell",
                                     for: indexPath)
                as! CategoryCollectionViewCell
            
            cell.backgroundColor = .clear
            let categoryView = CategoryView(category: categoriesInCollection[indexPath.row])
            
            for i in (categoryView.subviews[0] as! UIStackView).arrangedSubviews {
                if i is UILabel {
                    i.alpha = 0.0
                }
            }
            
            cell.view.addSubview(categoryView)
            return cell
            
        } else {
            let cell = keywordsCollectionView.dequeueReusableCell(withReuseIdentifier: "KeywordCell", for: indexPath) as! KeywordCollectionViewCell
            cell.backgroundColor = .clear
            let keyword = suggestedKeywords[indexPath.row]
            let keywordView = PTKeywordsLabel(text: keyword)
            cell.view.addSubview(keywordView)
            return cell
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            let item = collectionView.cellForItem(at: indexPath) as! CategoryCollectionViewCell
            let categoryView = item.view.subviews[0]  as! CategoryView
            categoryImagePressed(on: categoryView)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    
    
    
    
}

extension AddRecordChildVC {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard collectionView == keywordsCollectionView else { return CGSize.zero }
        let kwsize = PTKeywordsLabel(text: suggestedKeywords[indexPath.item]).frame.size
        
        print(kwsize)
        return kwsize
        
        
    }
}
