//
//  PTScrollView.swift
//  Money Tracker
//
//  Created by Петрос Тепоян on 11/11/19.
//  Copyright © 2019 Петрос Тепоян. All rights reserved.
//

import UIKit

class PTScrollView: UIScrollView {
    

}

extension UIScrollView {

    var isScrolledToTop: Bool {
        let topEdge = -20 - contentInset.top
        return contentOffset.y <= topEdge
    }

    var isScrolledToBottom: Bool {
        let bottomEdge = contentSize.height + contentInset.bottom - bounds.height
        return contentOffset.y >= bottomEdge
    }

}
