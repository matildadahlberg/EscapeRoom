import UIKit

class DescriptionViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    var updateTimeLabel = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTimeLabel = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    @objc func updateTime() {
        if Time.seconds < 60 {
            timeLabel.text = "\(Time.minute):\(Time.seconds)"
        }
        if Time.seconds == 60 {
            Time.minute += 1
            Time.seconds = 0
            timeLabel.text = "\(Time.minute):\(Time.seconds)"
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        updateTimeLabel.invalidate()
    }
}
