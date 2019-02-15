import UIKit

class MemoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, ShowsAlert {
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var timeLabel: UILabel!
    
    var model = CardModel()
    var cardArray = [Card]()
    var count = 0
    var firstFlippedCardIndex : IndexPath?
    var  cards : CardCollectionViewCell?
    var updateTimeLabel = Timer()
    let segue = "memorySegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTimeLabel = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        cardArray = model.getCards()
        collectionView.delegate = self
        collectionView.dataSource = self
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
            
            count += 1
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
        
        for card in cardArray {
            
            
            if card.isMatched == true && count == 3 {
                collectionView.isHidden = true
                showAlert(title: "You solved the memory", segue: segue)
            }
        }
    }
    
    @objc func updateTime() {
        
        if Time.seconds < 10 {
            timeLabel.text = "\(Time.minute):0\(Time.seconds)"
        }
        
        if Time.seconds == 10 || Time.seconds > 10 &&  Time.seconds < 60 {
            timeLabel.text = "\(Time.minute):\(Time.seconds)"
        }
        if Time.seconds == 60 {
            Time.minute += 1
            Time.seconds = 0
            timeLabel.text = "\(Time.minute):0\(Time.seconds)"
        }
    }
    
    @IBAction func exitButton(_ sender: Any) {
        exitAlert()
    }
}

