import UIKit

class TurnIphoneViewController: UIViewController {
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var unlockButton: UIButton!
    
    @IBOutlet weak var iphoneHorizontal: UIImageView!
    
    @IBOutlet weak var iphoneVertical: UIImageView!
    
    @IBOutlet weak var arrow: UIImageView!
    
    var currentAnimation = 0
    
    var descriptionLabel = UILabel()
    var right = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        
        iphoneHorizontal.isHidden = true
        
        exitButton.layer.cornerRadius = 15
        unlockButton.isHidden = true
        descriptionLabel = UILabel(frame: CGRect(x: self.view.frame.width/2 - 150, y: self.view.frame.height/2 - 50, width: 300, height: 100))
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 2
        descriptionLabel.font = UIFont(name: "Helvetica", size: 30)
        descriptionLabel.text = "Turn iPhone to the left and then back"
        self.view.addSubview(descriptionLabel)
        
        
        rotateIphone()
        
        
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
    
    
    func rotateIphone(){
        
        arrow.isHidden = false
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [],
                       animations: { [unowned self] in
                        switch self.currentAnimation {
                        case 0:
                            self.iphoneVertical.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
                        case 1:
                            self.iphoneVertical.transform = CGAffineTransform.identity
                        
                        default:
                            break
                        }
        }) { [unowned self] (finished: Bool) in
            self.arrow.isHidden = true
        }
        
        currentAnimation += 1
        
        if currentAnimation > 2 {
            currentAnimation = 0
        }
        
    }
    
   
    
}
