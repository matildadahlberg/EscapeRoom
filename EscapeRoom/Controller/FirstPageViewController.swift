import UIKit

class FirstPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradient: CAGradientLayer = CAGradientLayer()
        
        
        gradient.colors = [
            
            UIColor(red: 0.38, green: 0.61, blue: 0.51, alpha: 1).cgColor,
            
            UIColor(red: 0.32, green: 0.48, blue: 0.41, alpha: 1).cgColor,
            
            UIColor(red: 0.24, green: 0.24, blue: 0.24, alpha: 1).cgColor,
            
            UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1).cgColor
            
        ]
        
         let currentY = view.frame.origin.y
        let currentX = view.frame.origin.x
        
        gradient.locations = [0, 0.22, 0.67, 1]
        gradient.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.75, y: 0.5)
        
        gradient.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 0.79, c: -0.79, d: 0, tx: 0.5, ty: 0.43))
        
        gradient.bounds = view.bounds.insetBy(dx: -0.5*view.bounds.size.width, dy: -0.5*view.bounds.size.height)
        
        gradient.position = view.center
        
        view.layer.addSublayer(gradient)
        


      
    }
    
    
    
}
