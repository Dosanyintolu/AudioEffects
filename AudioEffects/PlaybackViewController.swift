//
//  PlaybackViewController.swift
//  AudioEffects
//
//  Created by Doyinsola Osanyintolu on 3/7/20.
//  Copyright © 2020 DoyinOsanyintolu. All rights reserved.
//

import UIKit
import AVFoundation

class PlaybackViewController: UIViewController {

    
      @IBOutlet weak var chipmunkButton: UIButton!
      @IBOutlet weak var vaderButton: UIButton!
      @IBOutlet weak var echoButton: UIButton!
      @IBOutlet weak var reverbButton: UIButton!
      @IBOutlet weak var stopButton: UIButton!
      @IBOutlet weak var slowButton: UIButton!
      @IBOutlet weak var rabbitButton: UIButton!
      
      
      var recordedAudioURL: URL!
      var audioFile:AVAudioFile!
      var audioEngine:AVAudioEngine!
      var audioPlayerNode: AVAudioPlayerNode!
      var stopTimer: Timer!
    
    override func viewDidLoad() {
       super.viewDidLoad()
        
        slowButton.imageView?.contentMode = .scaleAspectFit
        chipmunkButton.imageView?.contentMode = .scaleAspectFit
        rabbitButton.imageView?.contentMode = .scaleAspectFit
        vaderButton.imageView?.contentMode = .scaleAspectFit
        echoButton.imageView?.contentMode = .scaleAspectFit
        reverbButton.imageView?.contentMode = .scaleAspectFit
        stopButton.imageView?.contentMode = .scaleAspectFit
                    setupAudio()
         }
         override func viewWillAppear(_ animated: Bool) {
             super.viewWillAppear(animated)
             
             configureUI(.notPlaying)
         }
    
      enum Button: Int {
          case echo = 0, reverb, chipmunk, vader, slow, rabbit
      }
      
      @IBAction func playSoundForButton(_ sender: UIButton) {
          switch(Button(rawValue: sender.tag)!) {
          case .echo:
              playSound(echo: true)
          case .reverb:
              playSound(reverb: true)
          case .chipmunk:
              playSound(pitch: 1000)
          case .vader:
              playSound(pitch: -1000)
          case .slow:
            playSound(rate: 0.5)
          case .rabbit:
            playSound(rate: 2.0)
          }

          configureUI(.isplaying)
      }

      @IBAction func stopButtonPressed(_ sender: AnyObject) {
          stopAudio()
      }

}
