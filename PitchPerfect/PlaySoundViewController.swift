//
//  PlaySoundViewController.swift
//  PitchPerfect
//
//  Created by Ankit Garg on 11/16/15.
//  Copyright © 2015 Ankit Garg. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    @IBOutlet weak var slowPlay: UIButton!
    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
     var audioFile:AVAudioFile!
    override func viewDidLoad() {
        super.viewDidLoad()

        do{
            try  audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
            try  audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl)
            audioPlayer.enableRate = true
            try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        }catch {
            
        }
        
    
    }
    
    @IBAction func chipMunkPlay(sender: UIButton) {
        audioEngine = AVAudioEngine()
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = 1000
        audioEngine.attachNode(changePitchEffect)
//        var mixer = audioEngine.mainMixerNode;
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        do{
            try audioEngine.start()
        }
        catch{
            
        }
        audioPlayerNode.play()
    }

    @IBAction func darthVaderPlay(sender: UIButton) {
        audioEngine = AVAudioEngine()
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = -1000.00
        audioEngine.attachNode(changePitchEffect)
        //        var mixer = audioEngine.mainMixerNode;
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        do{
            try audioEngine.start()
        }
        catch{
            
        }
        audioPlayerNode.play()
    }
    @IBAction func fastPlay(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 1.5
        audioPlayer.currentTime = 0.0
        audioPlayer.volume = 1
        audioPlayer.play()
        print("fast play")
    }
    
    @IBAction func slowPlayTap(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 0.5
        audioPlayer.currentTime = 0.0
        audioPlayer.volume = 1
        audioPlayer.play()
        print("slow play")
    }
    
    @IBAction func stopSound(sender: UIButton) {
        audioPlayer.stop()
    }
    
}
