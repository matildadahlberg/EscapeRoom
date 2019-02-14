import UIKit

class PatPetViewController: UIViewController {
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var unlockButton: UIButton!
    
    var tapped = 0
    
    var imageView = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
 
}
