//
//  AudioPlayer.swift
//  InstaCOVID
//
//  Created by Shangzheng Ji on 12/9/20.
//  Copyright © 2020 team2. All rights reserved.
//

//import Foundation
//import UIKit
import AVFoundation
import SwiftUI


var applaudSoundAudioPlayer: AVAudioPlayer?


public func createAudioPlayers() {
    if let applaudSoundAudioFileUrl = Bundle.main.url(forResource: "ApplaudSound",
                                              withExtension: "wav") {
            do {
                applaudSoundAudioPlayer = try AVAudioPlayer(contentsOf: applaudSoundAudioFileUrl)
                applaudSoundAudioPlayer!.prepareToPlay()
            } catch {
                print("Unable to create applaudSoundAudioPlayer!")
            }
     
        } else {
            print("Unable to find ApplaudSound in the main bundle!")
        }
}



