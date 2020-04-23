//
//  AddRecordChildVC+Sound.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 23/4/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//


import AVFoundation

extension AddRecordChildVC {
    func playSound(sound: Sounds) {
        guard let soundsAreTurnedOn = UserDefaults.standard.value(forKey: "SoundsAreTurnedOn") else { return }
        guard soundsAreTurnedOn as! Bool else { return }
        guard let path = Bundle.main.path(forResource: sound.rawValue, ofType: nil) else { return }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            
            soundPlayer = try AVAudioPlayer(contentsOf: url)
            soundPlayer?.play()
            
        } catch {
            print("Sound not found")
        }
    }
}
