//
//  NewSoundViewController.swift
//  Soundboard
//
//  Created by Stefan Maier on 03/12/14.
//  Copyright (c) 2014 Stefan Maier. All rights reserved.
//

import UIKit
import AVFoundation


class NewSoundViewController : UIViewController {

    required init(coder aDecoder: NSCoder) {
        
        
        var baseString : String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as String
        
        var pathComponents = [baseString, "MyAudio.m4a"]
        self.audioURL = NSURL.fileURLWithPathComponents(pathComponents)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        var recordSettings: [NSObject : AnyObject] = Dictionary()
        
        recordSettings[AVFormatIDKey] = kAudioFormatMPEG4AAC
        
        recordSettings[AVSampleRateKey] = 44100.0
        
        recordSettings[AVNumberOfChannelsKey] = 2
        
        self.audioRecorder = AVAudioRecorder(URL: self.audioURL, settings: recordSettings, error: nil)
        
        self.audioRecorder.meteringEnabled = true
        
        self.audioRecorder.prepareToRecord()
        
        //Super init is below
        super.init(coder: aDecoder)
        
    }


    
    @IBOutlet weak var soundTextField: UITextField!
    @IBOutlet weak var recordButton: UIButton!
    
    var audioRecorder: AVAudioRecorder
    var audioURL: NSURL
    var previewsViewController = SoundListViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Roll Tide ...
        
        
    }
    @IBAction func recordTapped(sender: AnyObject) {
        
        if self.audioRecorder.recording{
            self.audioRecorder.stop()
            self.recordButton.setTitle("RECORD", forState: UIControlState.Normal)
        
        } else {
            var session = AVAudioSession.sharedInstance()
            session.setActive(true, error: nil)
            self.audioRecorder.record()
             self.recordButton.setTitle("Finish Recording", forState: UIControlState.Normal)
        }
    
       
        
    }
    
    
    
    @IBAction func cancelButton(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveButton(sender: AnyObject) {
        //Create a sound Object (name + sound)
        var sound = Sound()
        sound.name = self.soundTextField.text
        sound.url = self.audioURL
        
        //add sound to sounds array
        self.previewsViewController.sounds.append(sound)
        
        //dissmiss view
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
