import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    
    var time = UILabel()
    var seconds = 0
    var minute = 0
    var gameTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.layer.cornerRadius = 15
        totalTime.seconds = 0
        totalTime.minute = 0
        time.frame = CGRect(x: self.view.frame.width - 70, y: 40, width: 100, height: 20)
        self.view.addSubview(time)
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)
    }
    
    @objc func startTimer() {
        totalTime.seconds += 1
        if totalTime.seconds < 60 {
            time.text = "\(totalTime.seconds)s"
        }
        if totalTime.seconds == 60 {
            totalTime.seconds = 0
            totalTime.minute += 1
            time.text = "\(totalTime.minute)m \(totalTime.seconds)s"
        }
        if totalTime.minute > 0 {
            time.text = "\(totalTime.minute)m \(totalTime.seconds)s"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        gameTimer.invalidate()
    }
}


struct totalTime {
    static var seconds = 0
    static var minute = 0
    
}

