//
//  HomeController+ScrollView.swift
//  
//
//  Created by Петрос Тепоян on 8/3/20.
//

import UIKit

extension HomeController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let dy = tableView.contentOffset.y
        let generator = UIImpactFeedbackGenerator(style: .medium)
        
        if scrollViewIsShown {
            let cntr = CGFloat(110.0)
            arrowView.center.y = cntr
            
            if dy < -40 {
                scrollViewIsShown.toggle()
                generator.impactOccurred()
                hidingRecordsAnimation()
                
            } else if (dy < 40) && (dy > 0) {
                arrowView.rotate(angle: 0.3*(1 - dy/40))
                arrowView.center.y = cntr - dy * 0.5
                
            } else if (dy > -40) && (dy <= 0) {
                arrowView.center.y = cntr - dy * 0.5
                
            }
            
            
            
        } else {
            let cntr = CGFloat(377.5)
            arrowView.center.y = cntr
            
            if dy >= 40 {
                scrollViewIsShown.toggle()
                generator.impactOccurred()
                showingRecordsAnimation()
                
            } else if (dy > -40) && (dy < 0) {
                arrowView.rotate(angle: -0.3*(1 + dy/40))
                arrowView.center.y  = cntr - dy * 0.5
                
            } else if (dy < 40) && (dy >= 0) {
                arrowView.center.y = cntr - dy * 0.5
                
            }
            
        }
        
        
        
        
    }
}


