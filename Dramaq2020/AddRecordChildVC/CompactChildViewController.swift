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
    
    let recordWillBeDismissedFrame = CGRect(x: -150, y: -40, width: 1000, height: 120)
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        view.center = parent!.view.center
    }
    
    @objc func draggedView(_ sender:UIPanGestureRecognizer){
        
        self.view.bringSubviewToFront(view)
        let translation = sender.translation(in: self.view)
        view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
        
        
        if sender.state == .changed {       // The drag changed
            makeHapticTouchImpact(in: recordWillBeDismissedFrame)
            
        }
        
        if sender.state == .ended {         // The drag ended

            let willDism = recordWillBeDismissedFrame.contains(dragLabel.globalFrame!)
            
            if willDism {
                dismissTheWindow(parent as! HomeController)
                
            } else {
                viewGetBackAnimation()
                
            }
        }
        
    }
    
    func makeHapticTouchImpact(in rect: CGRect) {
        if rect.contains(dragLabel.globalFrame!){
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred(intensity: 0.3)
            
        }
    }
    
    func dismissTheWindow(_ parentHome: HomeController) {
        viewToDissapear()
        removeBlurFromParentView()
        parentHome.cancelLabel.removeFromSuperview()
        
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
    
    func removeBlurFromParentView() {
        let blurView = (parent as! HomeController).view.subviews.filter { $0 is UIVisualEffectView }
        guard !blurView.isEmpty else { return }
        blurView[0].removeFromSuperview()
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
                
                //self.view.transform = CGAffineTransform(scaleX: 0.9, y: 0.2)
                //self.view.center.y = 500
                self.view.alpha = 0.0
        }, completion: nil)
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
