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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTimeLabel = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake && count > 0 {
            count -= 1
            AudioServicesPlayAlertSound(1519)
        }
        
        if motion == .motionShake && count == 0 {
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


