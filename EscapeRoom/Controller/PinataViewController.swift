import UIKit

class PinataViewController: UIViewController {
    
    @IBOutlet weak var pinataImage: UIImageView!
    @IBOutlet weak var unlockButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    
    
    var timer = Timer()
    var seconds = 10
    var touches = -1
    
    var tapped = 0
    
    var timerLabel = UILabel()
    
    var pinataLabel = UILabel()
   
    var startButton = UIButton()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        unlockButton.layer.cornerRadius = 15
        exitButton.layer.cornerRadius = 15
        
        
        pinataImage.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        
        
        tap.numberOfTapsRequired = 1
        
        view.addGestureRecognizer(tap)
        
        
        
    }
    
    @objc func updateTimer() {
        if seconds > 1{
            seconds -= 1
            timerLabel.text = "\(seconds)"
        }else {
            timerLabel.text = "Tiden är ute"
            timerLabel.textColor = UIColor.red
        }
    }
    
    @objc func startTimer(){
        touches += 1
        if touches == 0{
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(PinataViewController.updateTimer)), userInfo: nil, repeats: true)
            startButton.isHidden = true
            pinataLabel.text = "Tap the pinata to destroy it!"
        }
        
        
        else{
            //CHANGE COLOR OF EVERY SQUARE
//            UIView.animate(withDuration: 0) {
//                self.progressCircle.frame.size.width += 10
//                self.progressCircle.frame.size.height += 10
//            }
            
            print("Toouches: \(touches)")
        }
    }
    
    func setupView(){
        
        self.view.backgroundColor = UIColor.lightGray
        
        //TIMER LABEL
        timerLabel = UILabel(frame: CGRect(x: self.view.frame.width/2 - 150, y: 100, width: 300, height: 60))
        timerLabel.textAlignment = .center
        timerLabel.text = "10"
        timerLabel.font = UIFont(name: "Helvetica", size: 40)
        self.view.addSubview(timerLabel)
        
        //pinata label
        pinataLabel = UILabel(frame: CGRect(x: self.view.frame.width/2 - 150, y: 600, width: 300, height: 60))
        pinataLabel.textAlignment = .center
        pinataLabel.text = "10"
        pinataLabel.font = UIFont(name: "Helvetica", size: 20)
        self.view.addSubview(pinataLabel)
        

        
        //START TIMER BUTTEN
        startButton = UIButton(frame: CGRect(x: self.view.frame.width/2 - 50, y: 600, width: 100, height: 100))
        startButton.layer.cornerRadius = 50
        startButton.backgroundColor = UIColor.black
        startButton.setTitleColor(UIColor.white, for: .normal)
        startButton.setTitle("START", for: .normal)
        startButton.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        self.view.addSubview(startButton)
        
        
    }
    
    @objc private func imageTapped(_ recognizer: UITapGestureRecognizer) {
        print("image tapped")
        
       tapped += 1
        
        if tapped == 20{
            pinataImage.image = UIImage(named: "destroyedPinata")
        }
        
      
    }
    
    
    
    
    
    
    
    
}


