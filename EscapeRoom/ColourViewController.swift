import UIKit
import AudioToolbox
import CoreLocation

class ColourViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager : CLLocationManager!
    var gameLabel = UILabel()
    var countLabel = UILabel()
    var startButton = UIButton()
    var gameText = "Skaka mobilen!"
    var count = 2
    var rounds = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.startUpdatingHeading()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        if newHeading.magneticHeading < 30 && count == 0 {
            self.view.backgroundColor = UIColor.green
            createAlert()
        }else{
            self.view.backgroundColor = UIColor.lightGray
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake && count > 0 && startButton.isHidden == true{
            count -= 1
            countLabel.text = "\(count) kvar"
            AudioServicesPlayAlertSound(1519)
        }
        
        if motion == .motionShake && count == 0 {
            countLabel.text = ""
            countLabel.font = UIFont(name: "Helvetica", size: 50)
            gameLabel.text = "Ställ dig mot norr"
        }
    }
   
    func createAlert(){
        let alert = UIAlertController(title: "Grattis du vann!", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func startGame(){
        startButton.isHidden = true
    }
    
    func setupView(){
        self.view.backgroundColor = UIColor.lightGray
        
        gameLabel = UILabel(frame: CGRect(x: self.view.frame.width/2 - 150 , y: 100, width: 300, height: 100))
        gameLabel.textAlignment = .center
        gameLabel.text = "\(gameText)"
        gameLabel.font = UIFont(name: "Helvetica", size: 30)
        self.view.addSubview(gameLabel)
        
        countLabel = UILabel(frame: CGRect(x: self.view.frame.width/2 - 150, y: 300, width: 300, height: 150))
        countLabel.textAlignment = .center
        countLabel.text = "\(count) kvar"
        countLabel.font = UIFont(name: "Helvetica", size: 100)
        self.view.addSubview(countLabel)
        
        startButton = UIButton(frame: CGRect(x: self.view.frame.width/2 - 50, y: 600, width: 100, height: 100))
        startButton.layer.cornerRadius = 50
        startButton.backgroundColor = UIColor.black
        startButton.setTitleColor(UIColor.white, for: .normal)
        startButton.setTitle("START", for: .normal)
        startButton.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        self.view.addSubview(startButton)
    }
}


