import UIKit
import MBCircularProgressBar
import AudioToolbox

class TapLockViewController: UIViewController, ShowsAlert {
    
    
    @IBOutlet weak var lockImage: UIImageView!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tapButton: UIButton!
    @IBOutlet weak var progressView: MBCircularProgressBarView!
    @IBOutlet weak var key1: UIImageView!
    @IBOutlet weak var key2: UIImageView!
    
    var tapped = 0
    let segue = "lockSegue"
    var gameTimer = GameTime()
    var updateTimeLabel = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        key2.isHidden = true
        tapButton.layer.cornerRadius = 0.5 * tapButton.bounds.size.width
        progressView.value = 0
        progressView.maxValue = 20
        updateTimeLabel = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    
    @IBAction func tapButton(_ sender: Any) {
        tapped += 1
        AudioServicesPlayAlertSound(1519)
        UIView.animate(withDuration: 0) {
            self.progressView.value = CGFloat(self.tapped)
        }
        
        if tapped % 2 == 0 {
            key1.isHidden = true
            key2.isHidden = false
        }
        
        if tapped % 2 != 0 {
            key1.isHidden = false
            key2.isHidden = true
        }
        
        if tapped == 20 {
            showAlert(title: "You unlocked the lock", segue: segue)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        updateTimeLabel.invalidate()
    }
    
    @IBAction func exitButton(_ sender: Any) {
        exitAlert()
    }
}


