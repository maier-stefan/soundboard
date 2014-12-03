//
//  SoundListViewController.swift
//  Soundboard
//
//  Created by Stefan Maier on 01/12/14.
//  Copyright (c) 2014 Stefan Maier. All rights reserved.
//

import UIKit
import AVFoundation

class SoundListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var audioPlayer = AVAudioPlayer()
    var sounds: [Sound] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Roll tide ...
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        var soundPath = NSBundle.mainBundle().pathForResource("test_file", ofType: "m4a")
        var soundURL = NSURL.fileURLWithPath(soundPath!)

        
        var mySound = Sound()
        mySound.name = "Stefan can sing"
        mySound.url = soundURL!
        self.sounds.append(mySound)
        
        var mySound2 = Sound()
        mySound2.name = "Dieter can sing too"
        mySound2.url = soundURL!
        self.sounds.append(mySound2)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sounds.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var sound = self.sounds[indexPath.row]
        var cell = UITableViewCell()
        cell.textLabel?.text = sound.name
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var soundPath = NSBundle.mainBundle().pathForResource("test_file", ofType: "m4a")
        var soundURL = NSURL.fileURLWithPath(soundPath!)
        
        self.audioPlayer = AVAudioPlayer(contentsOfURL: soundURL , error: nil)
        self.audioPlayer.play()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var nextViewController = segue.destinationViewController as NewSoundViewController
        nextViewController.previewsViewController = self
    }

}

