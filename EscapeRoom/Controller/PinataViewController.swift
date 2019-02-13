import UIKit

class PinataViewController: UIViewController {
    
    @IBOutlet weak var pinataImage: UIImageView!
    @IBOutlet weak var unlockButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    
    var time = UILabel()
    var timer = Timer()
    var seconds = 10
    var touches = -1
    

    var totalTimer = Timer()
    
    
    var tapped = 0
    var timerLabel = UILabel()
    var pinataLabel = UILabel()
    var startButton = UIButton()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        unlockButton.isHidden = true
        exitButton.layer.cornerRadius = 15

        totalTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateGameTimer), userInfo: nil, repeats: true)


        pinataImage.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func updateTimer() {
        if seconds > 0{
            seconds -= 1
            timerLabel.text = "\(seconds)"
        }
        if tapped != 20 && seconds == 0{
            timerLabel.text = "Oh, you were too slow!"
        }
    }
    
    func setupView(){
        
        //TIMER LABEL
        timerLabel = UILabel(frame: CGRect(x: self.view.frame.width/2 - 150, y: 100, width: 300, height: 90))
        timerLabel.textAlignment = .center
        timerLabel.text = "10"
        timerLabel.font = UIFont(name: "Helvetica", size: 30)
        timerLabel.numberOfLines = 2
        self.view.addSubview(timerLabel)
        
        //pinata label
        pinataLabel = UILabel(frame: CGRect(x: self.view.frame.width/2 - 150, y: 600, width: 300, height: 60))
        pinataLabel.textAlignment = .center
        pinataLabel.text = "Tap the pinata 20 times to destroy it!"
        pinataLabel.font = UIFont(name: "Helvetica", size: 20)
        pinataLabel.numberOfLines = 2
        self.view.addSubview(pinataLabel)
        
        time.frame = CGRect(x: self.view.frame.width - 70, y: 40, width: 100, height: 20)
        self.view.addSubview(time)
    }
    
    @objc private func imageTapped(_ recognizer: UITapGestureRecognizer) {
        
        tapped += 1
        touches += 1
        if touches == 0 {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(PinataViewController.updateTimer)), userInfo: nil, repeats: true)
        }
        if tapped == 20 && seconds > 0{
            pinataImage.image = UIImage(named: "destroyedPinata")
            unlockButton.isHidden = false
            unlockButton.layer.cornerRadius = 15
            timerLabel.isHidden = true
            pinataLabel.text = ""
        }
   
    }
    
    @objc func updateGameTimer() {
        totalTime.seconds += 1
        
        if totalTime.seconds < 60 {
            time.text = "\(totalTime.seconds)s"
        }
        
        if totalTime.seconds == 60 {
            totalTime.seconds = 0
            totalTime.minute += 1
            time.text = "\(totalTime.minute)m \(totalTime.seconds)s"
        }
        
        if totalTime.minute > 0 {
            time.text = "\(totalTime.minute)m \(totalTime.seconds)s"
        }

    }
    
}


