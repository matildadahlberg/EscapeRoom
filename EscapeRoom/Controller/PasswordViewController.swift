import UIKit
import AudioToolbox

class PasswordViewController: UIViewController, ShowsAlert {
    
    @IBOutlet weak var timeLabel: UILabel!
    var updateTimeLabel = Timer()
    let segue = "passwordSegue"
    
    @IBOutlet weak var passwordLabel: UILabel!
    
    var currentInput = ""
    let correctPassword = "2004"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTimeLabel = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
    }
    
    
    @IBAction func numberButton(_ sender: Any) {
        
        let button = sender as! UIButton
        let number = button.tag
        passwordLabel.text = passwordLabel.text! + String(number)
        
        if passwordLabel.text?.count == 4 && passwordLabel.text != correctPassword {
            AudioServicesPlayAlertSound(1519)
            passwordLabel.text = ""
        }
        if passwordLabel.text == correctPassword {
            showAlert(title: "Correct!", segue: segue)
        }
    }
    
    
    @IBAction func startOverButton(_ sender: Any) {
        passwordLabel.text = ""
    }
    
    @IBAction func exitButton(_ sender: Any) {
        exitAlert()
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
