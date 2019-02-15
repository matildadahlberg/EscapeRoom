import UIKit

class TurnIphoneViewController: UIViewController, ShowsAlert {
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var iphoneVertical: UIImageView!
    @IBOutlet weak var arrow: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var handle: UIImageView!
    
    @IBOutlet weak var keyHole: UIImageView!
    
    var descriptionLabel = UILabel()
    var right = false
    var updateTimeLabel = Timer()
    let segue = "doorSegue"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        updateTimeLabel = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
        UIView.animate(withDuration: 3.0, delay: 0, options: [.repeat, .autoreverse],
                       animations: { [unowned self] in
                        self.iphoneVertical.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
                        
                        self.arrow.transform = CGAffineTransform(translationX: 28, y: 35)
                        
        }) { [unowned self] (finished: Bool) in
            self.iphoneVertical.transform = CGAffineTransform.identity
            self.arrow.transform = CGAffineTransform.identity
            
        }
    }
    
    
    
    
    
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        
        if UIDevice.current.orientation == .landscapeRight {
            
            keyHole.frame = CGRect(x: 330, y: 180, width: 41, height: 39)
            handle.image = UIImage(named: "HandleDown")
            handle.frame = CGRect(x: 330, y: 110, width: 170, height: 80)
            iphoneVertical.frame = CGRect(x: 600, y: 270, width: 65, height: 110)
            arrow.frame = CGRect(x: 700, y: 340, width: 31, height: 43)
            timeLabel.frame = CGRect(x: 700, y: 30, width: 80, height: 27)
            
            right = true
        }
        if UIDevice.current.orientation == .portrait {
            
            if right == true {
                keyHole.frame = CGRect(x: self.view.frame.width/2 - 60, y: self.view.frame.width/2 + 150, width: 41, height: 39)
                handle.image = UIImage(named: "Handle")
                handle.frame = CGRect(x: self.view.frame.width/2 - 60, y: self.view.frame.width/2 + 90, width: 180, height: 35)
                timeLabel.frame = CGRect(x: 290, y: 50, width: 80, height: 27)
                showAlert(title: "You opened the door", segue: segue)
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
    
}
