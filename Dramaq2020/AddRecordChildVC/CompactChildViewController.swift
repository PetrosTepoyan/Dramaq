//
//  CompactChildViewController.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 7/3/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit

class CompactChildViewController: UIViewController {

    @IBOutlet weak var dragLabel: UILabel!
    var viewCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.clipsToBounds = true
        viewCenter = self.view.center
        
        setupConstrains()
        hideKeyboardWhenTouching()
        setupShadowAndCorners()
        setupDragLabel()
        setupPanGesture()
        
        
    }
    
    @objc func draggedView(_ sender:UIPanGestureRecognizer){
        
        self.view.bringSubviewToFront(view)
        let translation = sender.translation(in: self.view)
        view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
        
        let vCTR = view.center
        let parentHome = parent as! HomeController
        
        if sender.state == .changed {       // The drag changed
            makeHapticTouchImpact(vCTR)
        }
        
        if sender.state == .ended {         // The drag ended
            viewGetBackAnimation()
            dismissTheWindow(vCTR, parentHome)
            
            parentHome.tableView.reloadData()
        }
    }
    
    fileprivate func makeHapticTouchImpact(_ vCTR: CGPoint) {
        if (vCTR.x > -160) && (vCTR.x < 480) && (vCTR.y > 398.5) && (vCTR.y < 850){
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred(intensity: 0.3)
            
        }
    }
    fileprivate func dismissTheWindow(_ vCTR: CGPoint, _ parentHome: HomeController) {
        if (vCTR.x > -140) && (vCTR.x < 460) && (vCTR.y > 0) && (vCTR.y <= 270){
            
            viewToDissapear()
            parentHome.cancelLabel.removeFromSuperview()
            let blurViews = parentHome.view.subviews.filter { $0 is UIVisualEffectView }
            if !blurViews.isEmpty {
                blurViews[0].removeFromSuperview()
            }
            
        }
    }
    
    func setupPanGesture(){
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(draggedView))
        dragLabel.isUserInteractionEnabled = true
        dragLabel.addGestureRecognizer(panGesture)
    }
    
    func setupConstrains(){
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 488),
            view.widthAnchor.constraint(equalToConstant: 318),
            
        ])
        
        
        
    }
    
    func hideKeyboardWhenTouching(){
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
    }
    
    func viewGetBackAnimation(){
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 5,
            initialSpringVelocity: 0.3,
            options: .curveEaseInOut,
            animations: {
                self.view.center = self.viewCenter
                
        }, completion: {finish in
            
        }
        )
    }
    
    func viewToDissapear(){
        
        UIView.animate(
            withDuration: 0.45,
            delay: 0,
            usingSpringWithDamping: 6,
            initialSpringVelocity: 0.3,
            options: .curveEaseInOut,
            animations: {
                
                self.view.transform = CGAffineTransform(scaleX: 0.9, y: 0.2)
                self.view.center.y = 500
                self.view.alpha = 0.0
        }, completion: {finish in
        }
        )
    }
    
    func setupDragLabel(){
        dragLabel.clipsToBounds = true
        dragLabel.layer.cornerRadius = 30
        
        
    }
    
    func setupShadowAndCorners(){
        view.layer.cornerRadius  = 30
        view.layer.shadowColor   = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset  = CGSize(width: 0, height: 10)
        view.layer.shadowRadius = 10
    }

}
