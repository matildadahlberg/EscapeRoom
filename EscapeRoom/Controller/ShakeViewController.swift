import UIKit
import AudioToolbox


class ShakeViewController: UIViewController, ShowsAlert {
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var iphoneImage: UIImageView!
    @IBOutlet weak var arrow: UIImageView!
    
    var descriptionLabel = UILabel()
    var countLabel = UILabel()
    var count = 3
    var updateTimeLabel = Timer()
    let segue = "shakeSegue"

    let animation = CABasicAnimation(keyPath: "position")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTimeLabel = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animation.duration = 0.1
        animation.repeatDuration = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: iphoneImage.center.x - 10, y: iphoneImage.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: iphoneImage.center.x + 10, y: iphoneImage.center.y))
        
        iphoneImage.layer.add(animation, forKey: "position")
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake && count > 0 {
            animation.duration = 0.1
            animation.repeatDuration = 2
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: iphoneImage.center.x - 10, y: iphoneImage.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: iphoneImage.center.x + 10, y: iphoneImage.center.y))
            
            iphoneImage.layer.add(animation, forKey: "position")
            count -= 1
            AudioServicesPlayAlertSound(1519)
        }
        
        if motion == .motionShake && count == 0 {
            animation.duration = 0
            animation.repeatCount = 0
            animation.repeatDuration = 0
            animation.autoreverses = false
            iphoneImage.isHidden = true
            arrow.isHidden = true
            showAlert(title: "The door is open!", segue: segue)
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


