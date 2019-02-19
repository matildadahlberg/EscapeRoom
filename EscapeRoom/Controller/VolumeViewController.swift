import UIKit
import MediaPlayer
import AVFoundation


class VolumeViewController: UIViewController, ShowsAlert {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var volumeRed: UIImageView!
    @IBOutlet weak var volumeGrey: UIImageView!
    
    private var audioLevel : Float = 0.0
    var volume : Float = 0
    var updateTimeLabel = Timer()
    let segue = "wallSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTimeLabel = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
        listenVolumeButton()
        volume = AVAudioSession.sharedInstance().outputVolume
        
//        let currentY = imageView.frame.origin.y
//        if volume == 1.0{
//            UIView.animate(withDuration: 1, animations: {
//                self.imageView.frame = CGRect(x: 0, y: currentY + 820, width: self.view.frame.width, height: self.view.frame.height * 100)
//            }, completion: nil)
//            self.showAlert(title: "You are free!", segue: self.segue)
//        }
        
        volumeRed.isHidden = true
        
        var images: [UIImage] = []
        for i in 1...2 {
            images.append(UIImage(named: "volume\(i)")!)
        }
        volumeGrey.animationImages = images
        volumeGrey.animationDuration = 3.0
        volumeGrey.startAnimating()
    }
    
        
    
    override func viewWillAppear(_ animated: Bool) {
        listenVolumeButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let currentY = imageView.frame.origin.y
        if volume == 1.0{
            UIView.animate(withDuration: 6, animations: {
                self.imageView.frame = CGRect(x: 0, y: currentY + 820, width: self.view.frame.width, height: self.view.frame.height * 100)
            }, completion: nil)
            self.showAlert(title: "You are free!", segue: self.segue)
        }
    }
    
    func listenVolumeButton(){
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(true, options: [])
            audioSession.addObserver(self, forKeyPath: "outputVolume",
                                     options: NSKeyValueObservingOptions.new, context: nil)
            audioLevel = audioSession.outputVolume
        } catch {
            print("Error")
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "outputVolume"{
            let audioSession = AVAudioSession.sharedInstance()
            if audioSession.outputVolume > audioLevel {
                print("UPP")
                imageView.frame.origin.y += 50
            }
            
            audioLevel = audioSession.outputVolume
            print(audioSession.outputVolume)
            
            let currentY = imageView.frame.origin.y
            if audioLevel == 1.0{
                UIView.animate(withDuration: 5, animations: {
                    self.imageView.frame = CGRect(x: 0, y: currentY + 600, width: self.view.frame.width, height: self.view.frame.height * 100)
                }, completion: nil)
                showAlert(title: "You are free!", segue: segue)
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
