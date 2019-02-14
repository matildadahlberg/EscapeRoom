import UIKit
import MBCircularProgressBar
import AudioToolbox

class PinataViewController: UIViewController {
    
    @IBOutlet weak var pinataImage: UIImageView!
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
        progressView.value = 0
        progressView.maxValue = 20
        updateTimeLabel = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        unlockButton.isHidden = true
        exitButton.layer.cornerRadius = 15
        pinataImage.image = UIImage(named: "pinata")
    }
    
    
    @IBAction func tapButton(_ sender: Any) {
        tapped += 1
        
        UIView.animate(withDuration: 0) {
            self.progressView.value = CGFloat(self.tapped)
        }
        AudioServicesPlayAlertSound(1519)
        print("TAPPED")
        
        if tapped == 20 {
            pinataImage.image = UIImage(named: "destroyedPinata")
            unlockButton.isHidden = false
            tapButton.isHidden = true
            progressView.isHidden = true
            
            
        }
    }
    
    
    @objc func updateTime() {
        timeLabel.text = "\(Time.seconds)s"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        updateTimeLabel.invalidate()
    }
}


