//
//  DateButton.swift
//  Dramaq
//
//  Created by Петрос Тепоян on 26/1/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit


class DateSectionView: UIView {
    
    
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    var date: Date!
    
    
    convenience init(date: Date?){
        self.init()
        self.date = date
        setupView(date: date)
        
    }
    
    
    
    func setupView(date: Date?){
        let view = UIView()
        self.addSubview(view)
        self.frame = CGRect(x: 0, y: 0, width: 340, height: 30)
        view.frame = CGRect(x: 0, y: 0, width: 340, height: 30)
        
        let label = PTLabel()
        view.addSubview(label)
        label.text = date?.getDayExp()
        label.textAlignment = .center
        
        label.frame = CGRect(x: 170, y: 0, width: 158, height: 30)
        label.clipsToBounds = true
        label.layer.cornerRadius = 15
        label.layer.backgroundColor = UIColor.gray.withAlphaComponent(0.3).cgColor
        
        //setupBlur(on: label)

        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.2,
                       delay: 0.0,
                       usingSpringWithDamping: 10,
                       initialSpringVelocity: 2,
                       options: .allowUserInteraction,
                       animations: {
                        self.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        },
                       completion: nil)
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.2,
                       delay: 0.0,
                       usingSpringWithDamping: 10,
                       initialSpringVelocity: 2,
                       options: .allowUserInteraction,
                       animations: {
                        self.transform = CGAffineTransform(scaleX: 1, y: 1)
        },
                       completion: nil)
        super.touchesEnded(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesEnded(touches, with: event)
        super.touchesCancelled(touches, with: event)
    }
    
    
}



extension String {
  func toDate(withFormat format: String = "HH:mm") -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    guard let date = dateFormatter.date(from: self) else {
      preconditionFailure("Take a look to your format")
    }
    return date
  }
    
    
}

extension Array {
    mutating func turnToDates() -> [Date]{
        var dates: [Date] = []
        
        for i in self {
            dates.append((i as! String).toDate())
        }
        
        return dates
    }
    
    
}

//extension Dictionary {
//    mutating func sortForDates() -> [String]{
//        var keys = Array(self.keys)
//        var keysDate = keys.turnToDates()
//        keysDate.sort()
//        var keysDateString: [String] = []
//        
//        for i in keysDate {
//            keysDateString.append(i.getDay())
//        }
//        
//        keysDateString.reverse()
//        
//        return keysDateString
//    }
//}


