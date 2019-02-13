import UIKit
import AVFoundation

class StartViewController: UIViewController {
    
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var time: UILabel!
    
    var gameTime = GameTime()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startGameButton.layer.cornerRadius = 15
        time.text = "\(Time.seconds)"
    }
    
    @IBAction func startGameButton(_ sender: UIButton) {
        gameTime.gameTimer.invalidate()
        Time.seconds = 0
        Time.minute = 0
        gameTime.startGameTimer()
    }
}




