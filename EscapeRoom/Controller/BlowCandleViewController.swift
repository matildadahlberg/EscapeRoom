import UIKit
import AVFoundation
import CoreAudio

class BlowCandleViewController: UIViewController, ShowsAlert {
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var imageUnlight: UIImageView!
    
    var recorder: AVAudioRecorder!
    var levelTimer = Timer()
    var screenCracked = false
    var updateTimeLabel = Timer()
    let segue = "candleSegue"
   
    override func viewDidLoad() {
        super.viewDidLoad()
        imageUnlight.isHidden = true
        updateTimeLabel = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
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
        if level < 0 && level > -10{
            image.isHidden = true
            imageUnlight.isHidden = false
            levelTimer.invalidate()
            showAlert(title: "Good job!", segue: segue)
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
