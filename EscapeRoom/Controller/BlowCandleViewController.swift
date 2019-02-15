import UIKit
import AVFoundation
import CoreAudio

class BlowCandleViewController: UIViewController {
    
    @IBOutlet weak var unlockButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    
    var descriptionLabel = UILabel()
    var recorder: AVAudioRecorder!
    var levelTimer = Timer()
    var screenCracked = false
    var updateTimeLabel = Timer()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTimeLabel = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        exitButton.layer.cornerRadius = 15
        unlockButton.isHidden = true
        
        let documents = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0])
        let url = documents.appendingPathComponent("record.caf")
        
        let recordSettings: [String: Any] = [
            AVFormatIDKey:              kAudioFormatAppleIMA4,
            AVSampleRateKey:            44100.0,
            AVNumberOfChannelsKey:      2,
            AVEncoderBitRateKey:        12800,
            AVLinearPCMBitDepthKey:     16,
            AVEncoderAudioQualityKey:   AVAudioQuality.max.rawValue
        ]
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true)
            try recorder = AVAudioRecorder(url:url, settings: recordSettings)
            
        } catch {
            return
        }
        recorder.prepareToRecord()
        recorder.isMeteringEnabled = true
        recorder.record()
        levelTimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(decibelLevel), userInfo: nil, repeats: true)
        
    }
    
    @objc func decibelLevel() {
        recorder.updateMeters()
        let level = recorder.averagePower(forChannel: 0)
        
        if level < -10 && level > -20{
            image.isHidden = false
        }
        if level < 0 && level > -10{
            image.isHidden = false
            screenCracked = true
        }
        if level < 5 && level > 0 {
            image.isHidden = false
        }
        if level > 0 {
            image.isHidden = false
        }
        if screenCracked {
            levelTimer.invalidate()
            unlockButton.isHidden = false
            unlockButton.layer.cornerRadius = 15
            descriptionLabel.text = ""
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
