//
//  PlaySoundViewController.swift
//  EscapeRoom
//
//  Created by Matilda Dahlberg on 2019-02-06.
//  Copyright © 2019 Matilda Dahlberg. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet weak var startbuttonOutlet: UIButton!
    
    @IBOutlet var soundButtons: [UIButton]!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var unlockButton: UIButton!
    
    
    
    var playlist = [Int]()
    var currentItem = 0
    var readyForUser = false
    var numberOfTaps = 0
    
    var untilEnd = 0
    
    
    var playerD:AVAudioPlayer!
    var playerE:AVAudioPlayer!
    var playerF:AVAudioPlayer!
    var playerG:AVAudioPlayer!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exitButton.layer.cornerRadius = 15
        unlockButton.isHidden = true
        startbuttonOutlet.layer.cornerRadius = 10
        
        
        playSounds()
        
    }
    
    
    @IBAction func startSoundButton(_ sender: Any) {
        
        if readyForUser{
            let button = sender as! UIButton
            
            switch button.tag {
            case 1:
                playerD.play()
                checkIfCorrect(buttonPressed: 1)
            case 2:
                playerE.play()
                checkIfCorrect(buttonPressed: 2)
            case 3:
                playerF.play()
                checkIfCorrect(buttonPressed: 3)
            case 4:
                playerG.play()
                checkIfCorrect(buttonPressed: 4)
            default:
                break
            }
        }
        
    }
    
    @IBAction func startSound(_ sender: Any) {
        disableButtons()
        let randomNumber = Int(arc4random_uniform(4) + 1)
        playlist.append(randomNumber)
        startbuttonOutlet.isHidden = true
        playNextItem()
    }
    
    func playSounds() {
        let audioPlayerD = Bundle.main.path(forResource: "pianoD", ofType: "wav")!
        let urlD = URL(fileURLWithPath: audioPlayerD)
        
        let audioPlayerE = Bundle.main.path(forResource: "pianoE", ofType: "wav")!
        let urlE = URL(fileURLWithPath: audioPlayerE)
        
        let audioPlayerF = Bundle.main.path(forResource: "pianoF", ofType: "wav")!
        let urlF = URL(fileURLWithPath: audioPlayerF)
        
        let audioPlayerG = Bundle.main.path(forResource: "pianoG", ofType: "wav")!
        let urlG = URL(fileURLWithPath: audioPlayerG)
        
        do {
            try playerD = AVAudioPlayer(contentsOf: urlD)
            try playerE = AVAudioPlayer(contentsOf: urlE)
            try playerF = AVAudioPlayer(contentsOf: urlF)
            try playerG = AVAudioPlayer(contentsOf: urlG)
            
            
        }catch{
            print(error)
        }
        
        playerD.delegate = self
        playerE.delegate = self
        playerF.delegate = self
        playerG.delegate = self
        
        playerD.numberOfLoops = 0
        playerE.numberOfLoops = 0
        playerF.numberOfLoops = 0
        playerG.numberOfLoops = 0
        
        
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        if currentItem <= playlist.count - 1{
            playNextItem()
            
        }
            
            
        else{
            readyForUser = true
            resetButtonHighlights()
            enableButtons()
        }
        
    }
    
    func playNextItem(){
        let selectedItem = playlist[currentItem]
        
        switch selectedItem {
        case 1:
            highLightButtonWithTag(tag: 1)
            playerD.play()
            break
        case 2:
            highLightButtonWithTag(tag: 2)
            playerE.play()
            break
        case 3:
            highLightButtonWithTag(tag: 3)
            playerF.play()
            break
        case 4:
            highLightButtonWithTag(tag: 4)
            playerG.play()
            break
        default:
            break
        }
        
        currentItem += 1
    }
    
    func highLightButtonWithTag(tag: Int){
        switch tag {
        case 1:
            resetButtonHighlights()
            soundButtons[tag - 1].setImage(UIImage(named: "greenPressed"), for: .normal)
        case 2:
            resetButtonHighlights()
            soundButtons[tag - 1].setImage(UIImage(named:"bluePressed"), for: .normal)
        case 3:
            resetButtonHighlights()
            soundButtons[tag - 1].setImage(UIImage(named:"orangePressed"), for: .normal)
        case 4:
            resetButtonHighlights()
            soundButtons[tag - 1].setImage(UIImage(named:"redPressed"), for: .normal)
        default:
            break
        }
        
    }
    
    func resetButtonHighlights(){
        soundButtons[0].setImage(UIImage(named: "green"), for: .normal)
        soundButtons[1].setImage(UIImage(named: "blue"), for: .normal)
        soundButtons[2].setImage(UIImage(named: "orange"), for: .normal)
        soundButtons[3].setImage(UIImage(named: "red"), for: .normal)
        
    }
    
    func checkIfCorrect(buttonPressed: Int) {
        
        if buttonPressed == playlist[numberOfTaps]{
            if numberOfTaps == playlist.count - 1{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.10) {
                    self.anotherRound()
                }
                
                
            }
            
            numberOfTaps += 1
            
        }
            
        else{
            //game over
            resetGame()
            
        }
        
    }
    
    func resetGame(){
        readyForUser = false
        numberOfTaps = 0
        currentItem = 0
        playlist = []
        startbuttonOutlet.isHidden = false
        startbuttonOutlet.setTitle("Try again", for: .normal)
        untilEnd = 0
        disableButtons()
        
    }
    
    func anotherRound(){
        untilEnd += 1
        print(untilEnd)
        if untilEnd == 3{
            endOfGame()
            playerD.stop()
            playerE.stop()
            playerF.stop()
            playerG.stop()
        }
        else{
            readyForUser = false
            numberOfTaps = 0
            currentItem = 0
            disableButtons()
            
            let randomNumber = Int(arc4random_uniform(4) + 1)
            playlist.append(randomNumber)
            
            playNextItem()
        }
        
    }
    
    func endOfGame(){
        readyForUser = false
        numberOfTaps = 0
        currentItem = 0
        disableButtons()
        
        soundButtons[0].isHidden = true
        soundButtons[1].isHidden = true
        soundButtons[2].isHidden = true
        soundButtons[3].isHidden = true
        
        unlockButton.isHidden = false
        
    }
    
    func disableButtons(){
        for button in soundButtons{
            button.isUserInteractionEnabled = false
            
        }
        
    }
    
    func enableButtons(){
        for button in soundButtons{
            button.isUserInteractionEnabled = true
            
        }
    }
    
    
}
