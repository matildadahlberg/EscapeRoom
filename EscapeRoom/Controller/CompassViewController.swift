import UIKit
import AudioToolbox
import CoreLocation

class CompassViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var unlockButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    var locationManager : CLLocationManager!
    var descriptionLabel = UILabel()
    var countLabel = UILabel()
    var startButton = UIButton()
    var turns = 0
    var quarter = false
    var half = false
    var almostFull = false
    var full = false
    var updateTimeLabel = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        updateTimeLabel = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        unlockButton.isHidden = true
        exitButton.layer.cornerRadius = 15
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.startUpdatingHeading()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        
        if newHeading.magneticHeading < 90  {
            quarter = true
        }
        if newHeading.magneticHeading > 90 && newHeading.magneticHeading < 180 && quarter == true {
            half = true
        }
        if newHeading.magneticHeading > 180 && newHeading.magneticHeading < 270 && half == true {
            almostFull = true
        }
        if newHeading.magneticHeading > 340 && newHeading.magneticHeading < 359 && almostFull == true {
            turns += 1
            descriptionLabel.text = "1 turn left"
            countLabel.text = "-->"
            quarter = false
            half = false
            almostFull = false
            
            if turns == 2 {
                descriptionLabel.text = "Nice turns ;)"
                countLabel.text = ""
                unlockButton.isHidden = false
                unlockButton.layer.cornerRadius = 15
                locationManager.stopUpdatingHeading()
            }
            
        }
    }
    
    func setupView(){
        
        descriptionLabel = UILabel(frame: CGRect(x: self.view.frame.width/2 - 150 , y: 100, width: 300, height: 100))
        descriptionLabel.textAlignment = .center
        descriptionLabel.text = "Turn around 2 times"
        descriptionLabel.font = UIFont(name: "Helvetica", size: 30)
        self.view.addSubview(descriptionLabel)
        
        countLabel = UILabel(frame: CGRect(x: self.view.frame.width/2 - 150, y: 300, width: 300, height: 150))
        countLabel.textAlignment = .center
        countLabel.text = "-->"
        countLabel.font = UIFont(name: "Helvetica", size: 30)
        self.view.addSubview(countLabel)
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
}
