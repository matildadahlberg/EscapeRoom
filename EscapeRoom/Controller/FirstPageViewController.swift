import UIKit

class FirstPageViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradient: CAGradientLayer = CAGradientLayer()

        gradient.bounds = backgroundView.bounds.insetBy(dx: -0.5*view.bounds.size.width, dy: -0.5*view.bounds.size.height)
        
        gradient.position = backgroundView.center
     
        gradient.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.25, y: 0.75)
        gradient.locations = [0, 0.22, 0.67, 1]
        
        gradient.colors = [
            
            UIColor(red: 0.38, green: 0.61, blue: 0.51, alpha: 1).cgColor,
            
            UIColor(red: 0.32, green: 0.48, blue: 0.41, alpha: 1).cgColor,
            
            UIColor(red: 0.24, green: 0.24, blue: 0.24, alpha: 1).cgColor,
            
            UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1).cgColor
            
        ]
 
        backgroundView.layer.addSublayer(gradient)
    }
}
