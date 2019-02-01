import UIKit
import AudioToolbox

class ColourViewController: UIViewController {
    
    var timer = Timer()
    var seconds = 10
    var touches = -1
    
    var timerLabel = UILabel()
    var circle = UIButton()
    var progressCircle = UIButton()
    var startButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
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
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ColourViewController.updateTimer)), userInfo: nil, repeats: true)
        }else{
            //CHANGE COLOR OF EVERY SQUARE
            UIView.animate(withDuration: 0) {
                self.progressCircle.frame.size.width += 10
                self.progressCircle.frame.size.height += 10
            }
            AudioServicesPlayAlertSound(1519)
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
        
        //SETUP SQUARES
        circle = UIButton(frame: CGRect(x: self.view.frame.width/2 - 150, y: 230, width: 300, height: 300))
        circle.layer.cornerRadius = circle.frame.size.height/2
        circle.backgroundColor = UIColor.white
        self.view.addSubview(circle)
        
        progressCircle = UIButton(frame: CGRect(x: self.view.frame.width/2, y: self.view.frame.height/2, width: 0, height: 0))
        progressCircle.layer.cornerRadius = progressCircle.frame.size.height/2
        progressCircle.backgroundColor = UIColor.red
        self.view.addSubview(progressCircle)
        
        
        //START TIMER BUTTEN
        startButton = UIButton(frame: CGRect(x: self.view.frame.width/2 - 50, y: 600, width: 100, height: 100))
        startButton.layer.cornerRadius = 50
        startButton.backgroundColor = UIColor.black
        startButton.setTitleColor(UIColor.white, for: .normal)
        startButton.setTitle("START", for: .normal)
        startButton.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        self.view.addSubview(startButton)
        
        
    }
    
    
    
    
    
    
    
    
}


