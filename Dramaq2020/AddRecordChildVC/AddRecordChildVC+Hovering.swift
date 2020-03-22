//
//  AddRecordChildVC+Hovering.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 19/3/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import Foundation
import UIKit
extension AddRecordChildVC {
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("entered")
        if let touch = touches.first {
            let position = touch.location(in: view)
            print(position)
            print(upperStack.globalFrame!)
            if upperStack.globalFrame!.contains(position) {
                print("bum")
            }
        }
        super.touchesMoved(touches, with: event)
    }
}
