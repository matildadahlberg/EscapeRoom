import UIKit

class TurnIphoneViewController: UIViewController {
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var unlockButton: UIButton!
    
    
    @IBOutlet weak var iphoneVertical: UIImageView!
    
    @IBOutlet weak var arrow: UIImageView!
    
    @IBOutlet weak var iphoneHorizontal: UIImageView!
    var change = true
    
    var currentAnimation = 0
    
    var loop = 5
    

    
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
        
        iphoneHorizontal.isHidden = true
       
        for i in 1...2 {
//                arrow.isHidden = false

                UIView.animate(withDuration: 5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [],
                               animations: { [unowned self] in


                                    self.iphoneVertical.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
//                                self.arrow.isHidden = true




                }) { [unowned self] (finished: Bool) in
//                    self.arrow.isHidden = true
                    self.iphoneVertical.transform = CGAffineTransform.identity

                }
        }
  
//        var images: [UIImage] = []
//        for i in 1...2 {
//            images.append(UIImage(named: "i\(i)")!)
//        }
//        iphoneVertical.animationImages = images
//        iphoneVertical.animationDuration = 3.0
//        iphoneVertical.startAnimating()
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
    
    
    //    func rotateIphone(){
    //
    //        arrow.isHidden = false
    //
    //        UIView.animate(withDuration: 4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [],
    //                       animations: { [unowned self] in
    //
    //                        switch self.currentAnimation {
    //
    //                        case 0:
    //                            self.iphoneVertical.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
    //                            self.currentAnimation += 1
    //
    //                        case 1:
    //                            self.iphoneVertical.alpha = 0.1
    //                            self.iphoneVertical.backgroundColor = UIColor.green
    //                            self.currentAnimation -= 1
    //
    ////                        case 1:
    ////                            self.iphoneVertical.transform = CGAffineTransform.identity
    //
    //                        default:
    //                            break
    //                        }
    //
    //        }) { [unowned self] (finished: Bool) in
    //            self.arrow.isHidden = true
    //        }
    //
    //
    //
    //
    //        if currentAnimation > 0 {
    //            currentAnimation = 0
    //        }
    //
    //        print(currentAnimation)
    //
    //
    //
    //    }
    
    
    
}
