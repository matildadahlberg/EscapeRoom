import UIKit
import AVFoundation
import Vision

class CameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate, ShowsAlert {
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    let availableDevices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back).devices
    var foundObject : String = ""
    var previewLayer = AVCaptureVideoPreviewLayer()
    let captureSession = AVCaptureSession()
    var updateTimeLabel = Timer()
    let segue = "cameraSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTimeLabel = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        setupCaptureSession()
    }
    
    func setupCaptureSession() {
        // get capture device, add device input to capture session
        do {
            if let captureDevice = availableDevices.first {
                captureSession.addInput(try AVCaptureDeviceInput(device: captureDevice))
            }
        } catch {
            print(error.localizedDescription)
        }
        // setup output, add output to our capture session
        let captureOutput = AVCaptureVideoDataOutput()
        captureSession.addOutput(captureOutput)
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame.size = CGSize(width: 500, height:500 )
        previewLayer.position = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2)
        view.layer.addSublayer(previewLayer)
        captureSession.startRunning()
        captureOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let model = try? VNCoreMLModel(for: Resnet50().model) else { return }
        let request = VNCoreMLRequest(model: model) { (finishedRequest, error) in
            guard let results = finishedRequest.results as? [VNClassificationObservation] else { return }
            guard let Observation = results.first else { return }
            self.foundObject = "\(Observation.identifier)"
        
            DispatchQueue.main.async(execute: { [weak self] in
                if self?.foundObject == "envelope" {
                    AudioServicesPlayAlertSound(1519)
                    self?.previewLayer.isHidden = true
                    self?.captureSession.stopRunning()
                    self?.showAlert(title: "You found it!", segue: self!.segue)
                    
                }
            })
        }
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        // executes request
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
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






