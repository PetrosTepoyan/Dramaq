//
//  SoundManager.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 22/3/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import Foundation
import AVFoundation


enum Sounds: String{
    case recordWasAdded = "RecordWasAdded.m4a"
    
}

class SoundManager {
    
    var soundPlayer: AVAudioPlayer?
    
    init(soundPlayer: AVAudioPlayer?) {
        self.soundPlayer = soundPlayer
        prepareAudioSession()
    }
    
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
    
    
    ////
    var audioPlayer: AVAudioPlayer?

    func prepareAudioSession() -> Void {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
            try AVAudioSession.sharedInstance().setActive(true)

            prepareAudioPlayer()

        } catch {
            print("Issue with Audio Session")
        }
    }


    func prepareAudioPlayer() -> Void {

        let audioFileName = "test"
        let audioFileExtension = "mp3"

        guard let filePath = Bundle.main.path(forResource: audioFileName, ofType: audioFileExtension) else {
            print("Audio file not found at specified path")
            return
        }

        let alertSound = URL(fileURLWithPath: filePath)
        try? audioPlayer = AVAudioPlayer(contentsOf: alertSound)
        audioPlayer?.prepareToPlay()
    }


    func playAudioPlayer() -> Void {
        audioPlayer?.play()
    }


    func pauseAudioPlayer() -> Void {
        if audioPlayer?.isPlaying ?? false {
            audioPlayer?.pause()
        }
    }


    func stopAudioPlayer() -> Void {
        if audioPlayer?.isPlaying ?? false {
            audioPlayer?.stop()
        }
    }

    func resetAudioPlayer() -> Void {
        stopAudioPlayer()
        audioPlayer?.currentTime = 0
        playAudioPlayer()
    }
    
}
