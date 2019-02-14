import UIKit

class TurnIphoneViewController: UIViewController {
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var unlockButton: UIButton!
    
    @IBOutlet weak var iphoneVertical: UIImageView!
    @IBOutlet weak var arrow: UIImageView!
    
    var descriptionLabel = UILabel()
    var right = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exitButton.layer.cornerRadius = 15
        unlockButton.isHidden = true
        descriptionLabel = UILabel(frame: CGRect(x: self.view.frame.width/2 - 150, y: self.view.frame.height/2 - 50, width: 300, height: 100))
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 2
        descriptionLabel.font = UIFont(name: "Helvetica", size: 30)
        descriptionLabel.text = "Turn iPhone to the left and then back"
        self.view.addSubview(descriptionLabel)
        
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
            right = true
        }
        if UIDevice.current.orientation == .portrait {
            
            if right == true {
                descriptionLabel.text = ""
                unlockButton.isHidden = false
                unlockButton.layer.cornerRadius = 15
            }
        }
    }
    
}
