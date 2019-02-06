//
//  PlaySoundViewController.swift
//  EscapeRoom
//
//  Created by Matilda Dahlberg on 2019-02-06.
//  Copyright © 2019 Matilda Dahlberg. All rights reserved.
//

import UIKit
import AVFoundation
import SpriteKit

class PlaySoundViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var unlockButton: UIButton!
    
    @IBOutlet weak var greenOutler: UIButton!
    @IBOutlet weak var blueOutlet: UIButton!
    @IBOutlet weak var orangeOutlet: UIButton!
    @IBOutlet weak var redOutlet: UIButton!
    
    var playlist = [Int]()
    var currentItem = 0
    var readyForUser = false
    var numberOfTaps = 0
    
    
    var playerD : AVAudioPlayer = AVAudioPlayer()
    var playerE : AVAudioPlayer = AVAudioPlayer()
    var playerF : AVAudioPlayer = AVAudioPlayer()
    var playerG : AVAudioPlayer = AVAudioPlayer()
    
    let arrayOfSounds = ["pianoD","pianoF", "pianoG", "pianoE"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exitButton.layer.cornerRadius = 15
        unlockButton.isHidden = true
        
        greenOutler.layer.cornerRadius = 10
        blueOutlet.layer.cornerRadius = 10
        orangeOutlet.layer.cornerRadius = 10
        redOutlet.layer.cornerRadius = 10
        
        playSounds()
        
    }
    
    @IBAction func greenButton(_ sender: Any) {
        if readyForUser{
            playerD.play()
            checkIfCorrect(buttonPressed: greenOutler)
        }
    }
    @IBAction func blueButton(_ sender: Any) {
        if readyForUser{
            playerE.play()
            checkIfCorrect(buttonPressed: blueOutlet)
        }
    }
    
    @IBAction func orangeButton(_ sender: Any) {
        if readyForUser{
            playerF.play()
            checkIfCorrect(buttonPressed: orangeOutlet)
        }
    }
    
    @IBAction func redButton(_ sender: Any) {
        if readyForUser{
            playerG.play()
            checkIfCorrect(buttonPressed: redOutlet)
        }
    }
    
    @IBAction func startSound(_ sender: Any) {
        let randomNumber = Int(arc4random_uniform(4) + 1)
        playlist.append(randomNumber)
        //startSoundButton.isHidden = true
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
            try playerD = AVAudioPlayer(contentsOf: urlE)
            try playerD = AVAudioPlayer(contentsOf: urlF)
            try playerD = AVAudioPlayer(contentsOf: urlG)
            
            
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
            
        }else{
            readyForUser = true
            greenOutler.isHighlighted = false
            blueOutlet.isHighlighted = false
            orangeOutlet.isHighlighted = false
            redOutlet.isHighlighted = false
        }
        
    }
    
    func playNextItem(){
        let selectedItem = playlist[currentItem]
        
        switch selectedItem {
        case 1:
            playerD.play()
            greenOutler.isHighlighted = true
            break
        case 2:
            playerE.play()
            greenOutler.isHighlighted = false
            blueOutlet.isHighlighted = true
            break
        case 3:
            playerF.play()
            blueOutlet.isHighlighted = false
            orangeOutlet.isHighlighted = true
            break
        case 4:
            playerG.play()
            orangeOutlet.isHighlighted = false
            redOutlet.isHighlighted = true
            break
        default:
            break
        }
        
        currentItem += 1
    }
    
    func checkIfCorrect(buttonPressed: UIButton) {

//        if buttonPressed == playlist[numberOfTaps]{
            if numberOfTaps == playlist.count - 1{
                unlockButton.isHidden = false
            }
//        }

    }

    
    
    //    func playRed(){
    //        let audioPlayer = Bundle.main.path(forResource: "pianoG", ofType: "wav")!
    //        let url = URL(fileURLWithPath: audioPlayer)
    //
    //        do {
    //            player = try AVAudioPlayer(contentsOf: url)
    //            player.play()
    //        } catch {
    //            print("error")
    //        }
    //
    //    }
    
    
    
    
    
    
    
    
}
