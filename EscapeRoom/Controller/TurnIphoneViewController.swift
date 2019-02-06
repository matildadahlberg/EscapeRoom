import UIKit

class TurnIphoneViewController: UIViewController {
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var unlockButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exitButton.layer.cornerRadius = 15
        unlockButton.isHidden = false
        
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        var text=""
        switch UIDevice.current.orientation{
        case .portrait:
            text="Portrait"
        case .portraitUpsideDown:
            text="PortraitUpsideDown"
        case .landscapeLeft:
            text="LandscapeLeft"
        case .landscapeRight:
            text="LandscapeRight"
        default:
            text="Another"
        }
        NSLog("You have moved: \(text)")      
    }
    


}
