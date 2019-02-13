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
//        imageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.imageView.frame.height * volume)
        
       
        
//        label.text = "Lower the volume as much as possible to start the challange"
        
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
            let audioSession = AVAudioSession.sharedInstance().outputVolume
            
            
            
            
            if audioSession > 0{
                label.text = "Make the screen turn red by increase the volume"
                if audioSession > audioLevel {
                    
                    audioLevel = audioSession
                    
                    print("UPP: \(audioLevel)")
                    
                    
                        UIView.animate(withDuration: 1, animations: {
                            self.imageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.imageView.frame.height + 812/16 )
                            self.imageView.backgroundColor = UIColor.red
                        }, completion: nil)
                        
                    
                    if audioLevel > 0.0{
                        label.textColor = UIColor.white
                    }
                    
                    
                }
            }
            if audioSession < audioLevel {
                audioLevel = audioSession
                print("NER: \(audioLevel)")
                
                
                
                    UIView.animate(withDuration: 1, animations: {
                        self.imageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.imageView.frame.height - 800 )
                        self.imageView.backgroundColor = UIColor.blue
                        self.label.text = "Make the screen turn blue by lower the volume"
                    }, completion: nil)
                    
                    
                    if audioLevel < 0.5 {
                        unlockButton.isHidden = false
                        unlockButton.layer.cornerRadius = 15
                        label.isHidden = true
                    }
                
            }
            
        }
    }  
    
    
    
    
    
    
}
