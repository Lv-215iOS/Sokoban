//
//  AudioPlayer.swift
//  Sokoban
//
//  Created by Yuriy Lubinets on 1/27/17.
//
//

import Foundation
import AVFoundation

class AudioPlayer {
    
    static let sharedInstance = AudioPlayer()
    
    var backgroundMusicAudioPlayer: AVAudioPlayer?

    func backgroundMusic() {
        do {
            backgroundMusicAudioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "backgroundMusic", ofType: "wav")!))
            backgroundMusicAudioPlayer?.prepareToPlay()
            backgroundMusicAudioPlayer?.play()
        }
        catch {
            print(error)
        }
    }
    
    func playMusic() {
        backgroundMusicAudioPlayer?.play()
        UserDefaults.standard.set(true, forKey: "musicIsPlaying")
    }
    
    func stopMusic() {
        backgroundMusicAudioPlayer?.stop()
        UserDefaults.standard.set(false, forKey: "musicIsPlaying")
    }
    
}
