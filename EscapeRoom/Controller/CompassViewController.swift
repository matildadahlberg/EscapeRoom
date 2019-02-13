import UIKit
import AudioToolbox
import CoreLocation

class CompassViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var unlockButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    
    var locationManager : CLLocationManager!
    var descriptionLabel = UILabel()
    var countLabel = UILabel()
    var startButton = UIButton()
    var turns = 0
    var quarter = false
    var half = false
    var almostFull = false
    var full = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
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
}
