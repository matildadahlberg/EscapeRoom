import UIKit
import AVFoundation
import CoreAudio

class DistanceViewController: UIViewController {
    
    @IBOutlet weak var unlockButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    
    var descriptionLabel = UILabel()
    
    var recorder: AVAudioRecorder!
    var levelTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupText()
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
        print(level)
    }
    
    func setupText(){
        
        descriptionLabel = UILabel(frame: CGRect(x: self.view.frame.width/2 - 175 , y: self.view.frame.height/2 - 50, width: 350, height: 100))
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 2
        descriptionLabel.text = "Scream until the screen cracks "
        descriptionLabel.font = UIFont(name: "Helvetica", size: 30)
        self.view.addSubview(descriptionLabel)
        
    }
    

  

}
