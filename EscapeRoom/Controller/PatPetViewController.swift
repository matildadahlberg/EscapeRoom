import UIKit

class PatPetViewController: UIViewController {
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var unlockButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    var tapped = 0
    var updateTimeLabel = Timer()
    
    var imageView = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTimeLabel = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        exitButton.layer.cornerRadius = 15
        unlockButton.isHidden = true
        
        let imageName = "card1"
        let image = UIImage(named: imageName)
        imageView = UIImageView(image: image!)
        
        imageView.contentMode = .scaleAspectFit
        
        imageView.frame = CGRect(x: 45, y: 200, width: 300, height: 300)
        view.addSubview(imageView)

        imageView.isUserInteractionEnabled = true
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(imageSwiped))
        swipeLeft.direction = .left
        swipeLeft.numberOfTouchesRequired = 1
        imageView.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(imageSwiped))
        swipeRight.direction = .right
        swipeRight.numberOfTouchesRequired = 1
        imageView.addGestureRecognizer(swipeRight)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(imageSwiped))
        swipeUp.direction = .up
        swipeUp.numberOfTouchesRequired = 1
        imageView.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(imageSwiped))
        swipeDown.direction = .down
        swipeDown.numberOfTouchesRequired = 1
        imageView.addGestureRecognizer(swipeDown)
        
    }
    
    
    @objc func imageSwiped(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizer.Direction.right {
            print("Swipe Right")
            tapped += 1
            if tapped == 5{
                unlockButton.isHidden = false
                unlockButton.layer.cornerRadius = 15
                imageView.isHidden = true
            }
        }
        else if gesture.direction == UISwipeGestureRecognizer.Direction.left {
            print("Swipe Left")
            tapped += 1
            if tapped == 5{
                unlockButton.isHidden = false
                unlockButton.layer.cornerRadius = 15
                imageView.isHidden = true
            }
        }
        else if gesture.direction == UISwipeGestureRecognizer.Direction.up {
            print("Swipe Up")
            tapped += 1
            if tapped == 5{
                unlockButton.isHidden = false
                unlockButton.layer.cornerRadius = 15
                imageView.isHidden = true
            }
        }
        else if gesture.direction == UISwipeGestureRecognizer.Direction.down {
            print("Swipe Down")
            tapped += 1
            if tapped == 5{
                unlockButton.isHidden = false
                unlockButton.layer.cornerRadius = 15
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
    
 
}
