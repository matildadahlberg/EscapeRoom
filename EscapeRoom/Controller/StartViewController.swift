import UIKit
import AVFoundation

class StartViewController: UIViewController {
    
    @IBOutlet weak var startGameButton: UIButton!
    
    var gameTime = GameTime()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startGameButton.layer.cornerRadius = 15
    }
    
    @IBAction func startGameButton(_ sender: UIButton) {
        gameTime.stopGameTimer()
        gameTime.startGameTimer()
        Time.seconds = 0
        Time.minute = 0
        
    }
}




