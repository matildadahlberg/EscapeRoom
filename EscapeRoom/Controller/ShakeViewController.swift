import UIKit
import AudioToolbox


class ShakeViewController: UIViewController {
    
    @IBOutlet weak var unlockButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    var descriptionLabel = UILabel()
    var countLabel = UILabel()
    var count = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        unlockButton.isHidden = true
        exitButton.layer.cornerRadius = 15
        setupView()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake && count > 0 {
            count -= 1
            countLabel.text = "\(count)"
            AudioServicesPlayAlertSound(1519)
        }
        
        if motion == .motionShake && count == 0 {
            descriptionLabel.text = ""
            countLabel.text = ""
            unlockButton.isHidden = false
            unlockButton.layer.cornerRadius = 15
        }
    }
    
    func setupView(){
        
        descriptionLabel = UILabel(frame: CGRect(x: self.view.frame.width/2 - 150 , y: 100, width: 300, height: 100))
        descriptionLabel.textAlignment = .center
        descriptionLabel.text = "Shake the phone"
        descriptionLabel.font = UIFont(name: "Helvetica", size: 30)
        self.view.addSubview(descriptionLabel)
        
        countLabel = UILabel(frame: CGRect(x: self.view.frame.width/2 - 150, y: 300, width: 300, height: 200))
        countLabel.textAlignment = .center
        countLabel.text = "\(count)"
        countLabel.font = UIFont(name: "Helvetica", size: 200)
        self.view.addSubview(countLabel)
        
    }
}


