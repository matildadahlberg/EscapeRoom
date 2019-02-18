import UIKit

class DescriptionViewController: UIViewController, ShowsAlert {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func exitButton(_ sender: Any) {
        exitAlert()
    }
}
