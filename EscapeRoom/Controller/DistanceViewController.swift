import UIKit
import CoreLocation

class DistanceViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var unlockButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    
    var descriptionLabel = UILabel()
    var metersLeftLabel = UILabel()
    
    let locationManager = CLLocationManager()
    var startCoordinates = CLLocation()
    var newLati = ""
    var newLong = ""
    var metersLeft = 10
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupText()
        exitButton.layer.cornerRadius = 15
        unlockButton.isHidden = true
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()

        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locationValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        
        startCoordinates = CLLocation(latitude: locationValue.latitude, longitude: locationValue.longitude)
        print("START: \(startCoordinates)")
        
        
        let currentCoordinates = CLLocation(latitude: locationValue.latitude, longitude: locationValue.longitude)
        print("NEW: \(currentCoordinates)")
        
        let distance = currentCoordinates.distance(from: startCoordinates) / 1000
        
        print("DISTANSEN ÄR: \(distance) km")
    }

    
    
    
    func setupText(){
        
        descriptionLabel = UILabel(frame: CGRect(x: self.view.frame.width/2 - 175 , y: 100, width: 350, height: 100))
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 2
        descriptionLabel.text = "Move yourself 10 meters in any direction"
        descriptionLabel.font = UIFont(name: "Helvetica", size: 30)
        self.view.addSubview(descriptionLabel)
        
        metersLeftLabel = UILabel(frame: CGRect(x: self.view.frame.width/2 - 250, y: 300, width: 500, height: 200))
        metersLeftLabel.textAlignment = .center
        metersLeftLabel.text = "\(metersLeft)m"
        metersLeftLabel.font = UIFont(name: "Helvetica", size: 150)
        self.view.addSubview(metersLeftLabel)
        
    
    }
    

  

}
