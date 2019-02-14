import UIKit

class PatPetViewController: UIViewController {
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var unlockButton: UIButton!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        exitButton.layer.cornerRadius = 15
        unlockButton.isHidden = true
    

    }
    
}
