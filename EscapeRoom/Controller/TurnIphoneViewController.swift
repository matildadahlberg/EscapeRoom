import UIKit

class TurnIphoneViewController: UIViewController, ShowsAlert {
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var iphoneVertical: UIImageView!
    @IBOutlet weak var arrow: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var handle: UIImageView!
    @IBOutlet weak var keyHole: UIImageView!
    
    
    @IBOutlet weak var openDoorLabel: UILabel!
    
    
    @IBOutlet weak var arrowUp: UIImageView!
    @IBOutlet weak var iphoneLandscape: UIImageView!
    @IBOutlet weak var keyHoleLandscape: UIImageView!
    @IBOutlet weak var handleDown: UIImageView!
    
    
    var descriptionLabel = UILabel()
    var right = false
    var updateTimeLabel = Timer()
    let segue = "doorSegue"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        handleDown.isHidden = true
        keyHoleLandscape.isHidden = true
        arrowUp.isHidden = true
        iphoneLandscape.isHidden = true
        
        updateTimeLabel = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 3.0, delay: 0, options: [.repeat, .autoreverse],
                       animations: { [unowned self] in
                        self.iphoneVertical.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
                        
                        self.arrow.transform = CGAffineTransform(translationX: 28, y: 35)
                        
        }) { [unowned self] (finished: Bool) in
            self.iphoneVertical.transform = CGAffineTransform.identity
            self.arrow.transform = CGAffineTransform.identity
            
        }
        
        
        iphoneLandscape.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
        
        UIView.animate(withDuration: 3.0, delay: 0, options: [.repeat, .autoreverse],
                       animations: { [unowned self] in
                        self.iphoneLandscape.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi))
                        
                        self.arrowUp.transform = CGAffineTransform(translationX: 0, y: 40)
                        
        }) { [unowned self] (finished: Bool) in
            self.iphoneLandscape.transform = CGAffineTransform.identity
            self.arrow.transform = CGAffineTransform.identity
        }

    }
    
    
    
    
    
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        
        if UIDevice.current.orientation == .landscapeRight {
            
            handle.isHidden = true
            keyHole.isHidden = true
            arrow.isHidden = true
            iphoneVertical.isHidden = true
            openDoorLabel.isHidden = true
            
            
            handleDown.isHidden = false
            keyHoleLandscape.isHidden = false
            arrowUp.isHidden = false
            iphoneLandscape.isHidden = false
            iphoneLandscape.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
            
            right = true
        }
        if UIDevice.current.orientation == .portrait {
            
            if right == true {
             
                handleDown.isHidden = true
                keyHoleLandscape.isHidden = true
                arrowUp.isHidden = true
                iphoneLandscape.isHidden = true
                
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
    @IBAction func exitButton(_ sender: Any) {
        exitAlert()
    }
    
}
