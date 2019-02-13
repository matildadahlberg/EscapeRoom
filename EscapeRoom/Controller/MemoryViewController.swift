//
//  MemoryViewController.swift
//  EscapeRoom
//
//  Created by Matilda Dahlberg on 2019-02-08.
//  Copyright © 2019 Matilda Dahlberg. All rights reserved.
//

import UIKit

class MemoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    @IBOutlet weak var exitButton: UIButton!
    
    @IBOutlet weak var unlockButton: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    var model = CardModel()
    var cardArray = [Card]()
    
    
    var firstFlippedCardIndex : IndexPath?
    
    var  cards : CardCollectionViewCell?
    
    
    
    var timerLabel = UILabel()
    var restartTimeButton = UIButton()
    
    var timer = Timer()
    var seconds = 10
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exitButton.layer.cornerRadius = 15
        unlockButton.isHidden = true
        
        cardArray = model.getCards()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        timerLabel = UILabel(frame: CGRect(x: self.view.frame.width/2 - 150, y: 60, width: 300, height: 90))
        timerLabel.textAlignment = .center
        timerLabel.text = "10"
        timerLabel.font = UIFont(name: "Helvetica", size: 30)
        timerLabel.numberOfLines = 2
        self.view.addSubview(timerLabel)
        
        restartTimeButton = UIButton(type: .system) // let preferred over var here
        restartTimeButton.frame = CGRect(x: self.view.frame.width/2 - 150, y: 700, width: 300, height: 44)
        restartTimeButton.backgroundColor = UIColor.black
        restartTimeButton.setTitleColor(.white, for: .normal)
        restartTimeButton.setTitle("Try Again", for: .normal)
        restartTimeButton.addTarget(self, action: #selector(MemoryViewController.resetTimer), for: UIControl.Event.touchUpInside)
        self.view.addSubview(restartTimeButton)
        
        startTimer()
        
        
        
        
    }
    
    @objc func countdownTimer(){
        if seconds > 0{
            seconds -= 1
            timerLabel.text = "\(seconds)"
        }
    }
    
    @objc func resetTimer(){
   
        timer.invalidate()
        seconds = 10
        timerLabel.text = "10"
        cards?.getBackCards()
        collectionView.reloadData()
        startTimer()
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(countdownTimer)), userInfo: nil, repeats: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        let card = cardArray[indexPath.row]
        
        cell.setCard(card)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //check if time left, then you wont be able to turn cards
        if seconds <= 0{
            return
            
        }
        
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        let card = cardArray[indexPath.row]
        
        if card.isFlipped == false && card.isMatched == false {
            cell.flip()
            
            card.isFlipped = true
            
            if firstFlippedCardIndex == nil{
                firstFlippedCardIndex = indexPath
            }
            else{
                
                checkForMatches(indexPath)
                
            }
            
        }
    }
    
    func checkForMatches(_ secondFlippedCardIndex : IndexPath){
        
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        let cardOne = cardArray[firstFlippedCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]
        
        if cardOne.imageName == cardTwo.imageName{
            
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            checkGameEnded()
         
        }
        else{
            
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
            
            
        }
       
        
        firstFlippedCardIndex = nil
        
    }
    
    
    func checkGameEnded(){
        
        var isWon = true
        
        for card in cardArray {
            
            if card.isMatched == false {
                isWon = false
                break
            }
            
        }
        
        if isWon == true {
            
            //if theres time left and every card is matched, do this
            if seconds > 0{
                timer.invalidate()
            }
            unlockButton.isHidden = false
            print("win")
            
        }
        else{
            
            //if theres no time left and every card is not matched, do this
            if seconds > 0{
                return
                
                
                
            }
            
            print("lose")
            
        }
        
    }
    
    
}

