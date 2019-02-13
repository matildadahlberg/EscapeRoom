import UIKit

class DescriptionViewController: UIViewController {
    
    
    @IBOutlet weak var timeLabel: UILabel!
    var updateTimeLabel = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTimeLabel = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        timeLabel.text = "\(Time.seconds)s"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        updateTimeLabel.invalidate()
    }
}
