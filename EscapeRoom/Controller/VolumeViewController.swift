//
//  VolumeViewController.swift
//  EscapeRoom
//
//  Created by Matilda Dahlberg on 2019-02-11.
//  Copyright © 2019 Matilda Dahlberg. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation

class VolumeViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var unlockButton: UIButton!
    
    private var audioLevel : Float = 0.0
    var volume : Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        unlockButton.isHidden = true
        exitButton.layer.cornerRadius = 15
        
        listenVolumeButton()
        
        volume = AVAudioSession.sharedInstance().outputVolume
        
        imageView.backgroundColor = UIColor.red
        imageView.frame = CGRect(x: 0, y: self.view.frame.maxY, width: self.view.frame.width, height: self.view.frame.height * CGFloat(volume))
        
        let currentY = imageView.frame.origin.y
        
        if volume == 1.0{
            UIView.animate(withDuration: 1, animations: {
                self.imageView.frame = CGRect(x: 0, y: currentY - 820, width: self.view.frame.width, height: self.view.frame.height * 100)
            }, completion: nil)
            unlockButton.isHidden = false
            unlockButton.layer.cornerRadius = 15
            label.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        listenVolumeButton()
    }
    
    func listenVolumeButton(){
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(true, options: [])
            audioSession.addObserver(self, forKeyPath: "outputVolume",
                                     options: NSKeyValueObservingOptions.new, context: nil)
            audioLevel = audioSession.outputVolume
        } catch {
            print("Error")
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "outputVolume"{
            let audioSession = AVAudioSession.sharedInstance()
            
            let currentY = imageView.frame.origin.y
            
            if audioSession.outputVolume > 0{
                
                label.text = "Make the screen turn red by increase the volume"
                if audioSession.outputVolume > audioLevel {
                    audioLevel = audioSession.outputVolume
                    
                    UIView.animate(withDuration: 1, animations: {
                        self.imageView.frame = CGRect(x: 0, y: currentY - 50, width: self.view.frame.width, height: self.view.frame.height)
                        self.imageView.backgroundColor = UIColor.red
                    }, completion: nil)
                    
                    if audioLevel == 1.0{
                        UIView.animate(withDuration: 1, animations: {
                            self.imageView.frame = CGRect(x: 0, y: currentY - 600, width: self.view.frame.width, height: self.view.frame.height * 100)
                        }, completion: nil)
                        unlockButton.isHidden = false
                        unlockButton.layer.cornerRadius = 15
                        label.isHidden = true
                    }
                }
            }
        }
    }
}
