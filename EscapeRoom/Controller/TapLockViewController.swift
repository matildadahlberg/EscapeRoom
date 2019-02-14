import UIKit
import MBCircularProgressBar
import AudioToolbox

class TapLockViewController: UIViewController {
    
    @IBOutlet weak var lockImage: UIImageView!
    @IBOutlet weak var unlockButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tapButton: UIButton!
    @IBOutlet weak var progressView: MBCircularProgressBarView!
    
    var tapped = 0
    var gameTimer = GameTime()
    var updateTimeLabel = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapButton.layer.cornerRadius = 0.5 * tapButton.bounds.size.width
        progressView.value = 0
        progressView.maxValue = 20
        updateTimeLabel = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        unlockButton.isHidden = true
        exitButton.layer.cornerRadius = 15
        lockImage.image = UIImage(named: "Lock1")
    }
    
    
    @IBAction func tapButton(_ sender: Any) {
        tapped += 1
        AudioServicesPlayAlertSound(1519)
        UIView.animate(withDuration: 0) {
            self.progressView.value = CGFloat(self.tapped)
        }
        
        if tapped % 2 == 0 {
            lockImage.image = UIImage(named: "Lock1")
        }
        
        if tapped % 2 != 0 {
             lockImage.image = UIImage(named: "Lock2")
        }
        
        if tapped == 20 {
            lockImage.image = UIImage(named: "destroyedPinata")
            unlockButton.isHidden = false
            tapButton.isHidden = true
            progressView.isHidden = true
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
}


