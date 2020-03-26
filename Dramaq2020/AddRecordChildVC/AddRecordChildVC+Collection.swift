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
            print(keywords.count)
            return keywords.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView {
            let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoryViewCollectionCell", for: indexPath) as! CategoryCollectionViewCell
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
            let cell = keywordsCollectionView.dequeueReusableCell(withReuseIdentifier: "KeywordCell", for: indexPath)
            let keyword = keywords[indexPath.row]
            let keywordLabel = PTKeywordsLabel(text: keyword)
            cell.contentView.addSubview(keywordLabel)
            cell.isHidden = false
            cell.backgroundColor = .black
            print(cell)
            print(cell.subviews)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = collectionView.cellForItem(at: indexPath) as! CategoryCollectionViewCell
        let categoryView = item.view.subviews[0]  as! CategoryView
        categoryImagePressed(on: categoryView)
        
    }
    
    
    
    
}
