import UIKit
import AudioToolbox
import CoreLocation

class CompassViewController: UIViewController, CLLocationManagerDelegate, ShowsAlert {
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var compass: UIImageView!
    var locationManager : CLLocationManager!
    var turns = 0
    var quarter = false
    var half = false
    var almostFull = false
    var full = false
    var updateTimeLabel = Timer()
    let segue = "compassSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTimeLabel = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.startUpdatingHeading()
        
        
        UIView.animate(withDuration: 10.0, delay: 0, options: [.repeat],
                       animations: { [unowned self] in
                        self.compass.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 2.0))
                        
                        
        }) { [unowned self] (finished: Bool) in
            self.compass.transform = CGAffineTransform.identity
        }
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
            quarter = false
            half = false
            almostFull = false
            
            if turns == 2 {
                showAlert(title: "Opened!", segue: segue)
                locationManager.stopUpdatingHeading()
            }
            
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
