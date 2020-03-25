//
//  RecordViewController.swift
//  AudioEffects
//
//  Created by Doyinsola Osanyintolu on 3/6/20.
//  Copyright © 2020 DoyinOsanyintolu. All rights reserved.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController, AVAudioRecorderDelegate{
    
    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recordingState(isRecording: false)

    }

    @IBAction func recordButtonPressed(_ sender: Any) {
        recordingState(isRecording: true)
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
               let recordingName = "recordedVoice.wav"
               let pathArray = [dirPath, recordingName]
               let filePath = URL(string: pathArray.joined(separator: "/"))
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)

        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    @IBAction func stopButtonPressed(_ sender: Any) {
        recordingState(isRecording: false)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func recordingState(isRecording: Bool) {
        stopButton.isEnabled = isRecording
        recordButton.isEnabled = !isRecording
        recordingLabel.text = !isRecording ? "Tap to Record": "Now Recording...."
     }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
            performSegue(withIdentifier: "recordSegue", sender: audioRecorder.url)
        }else {
            showAlert(title: "Something went wrong!", mesasge: "Unsuccessful recording")
        
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let segueName = "recordSegue"
        if segue.identifier == segueName {
            let playbackVC = segue.destination as! PlaybackViewController
            let recordedAudioURL = sender as! URL
            playbackVC.recordedAudioURL = recordedAudioURL
        }
    }
    
    func showAlert(title:String, mesasge: String) {
        
        let alert = UIAlertController(title: title, message: mesasge, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: title, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
     
}

