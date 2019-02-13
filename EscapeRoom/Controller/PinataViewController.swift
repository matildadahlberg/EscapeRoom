import UIKit

class PinataViewController: UIViewController {
    
    @IBOutlet weak var pinataImage: UIImageView!
    @IBOutlet weak var unlockButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    var touches = -1
    var tapped = 0
    var gameTimer = GameTime()
    var updateTimeLabel = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTimeLabel = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        unlockButton.isHidden = true
        exitButton.layer.cornerRadius = 15
        pinataImage.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
    }
    
    @objc private func imageTapped(_ recognizer: UITapGestureRecognizer) {
        tapped += 1
        touches += 1
        if touches == 0 {
        }
        if tapped == 20 {
            pinataImage.image = UIImage(named: "destroyedPinata")
            unlockButton.isHidden = false
            unlockButton.layer.cornerRadius = 15
        }
    }
    
    @objc func updateTime() {
        timeLabel.text = "\(Time.seconds)s"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        updateTimeLabel.invalidate()
    }
}


