import UIKit
import AudioToolbox

class PatPetViewController: UIViewController, ShowsAlert {
    
    @IBOutlet weak var strokeLabel: UILabel!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    var tapped = 0
    var updateTimeLabel = Timer()
    var imageView = UIImageView()
    let segue = "dogSegue"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTimeLabel = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
       
        let imageName = "Dog"
        let image = UIImage(named: imageName)
        imageView = UIImageView(image: image!)
        
        imageView.contentMode = .scaleAspectFit
        
        imageView.frame = CGRect(x: 45, y: 200, width: 300, height: 300)
        view.addSubview(imageView)

        imageView.isUserInteractionEnabled = true
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(imageSwiped))
        swipeDown.direction = .down
        swipeDown.numberOfTouchesRequired = 1
        imageView.addGestureRecognizer(swipeDown)
        
    }
    
    
    @objc func imageSwiped(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizer.Direction.down {
            print("Swipe Down")
            tapped += 1
         
            AudioServicesPlayAlertSound(1519)
            if tapped == 5{
                imageView.alpha = 0.1
                AudioServicesPlayAlertSound(1519)
                showAlert(title: "Happy dog!", segue: segue)
                imageView.isHidden = true
            }
        }
    }
    
    @objc func updateTime() {
        
        if Time.seconds < 10 {
            timeLabel.text = "\(Time.minute):0\(Time.seconds)"
        }
        
        if Time.seconds == 10 || Time.seconds > 10 &&  Time.seconds < 60 {
            timeLabel.text = "\(Time.minute):\(Time.seconds)"
        }
        if Time.seconds == 60 {
            Time.minute += 1
            Time.seconds = 0
            timeLabel.text = "\(Time.minute):0\(Time.seconds)"
        }
    }
    
    @IBAction func exitButton(_ sender: Any) {
        exitAlert()
    }
    
}
