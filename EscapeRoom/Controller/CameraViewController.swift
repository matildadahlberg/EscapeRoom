//
//  CameraViewController.swift
//  EscapeRoom
//
//  Created by Matilda Dahlberg on 2019-02-04.
//  Copyright © 2019 Matilda Dahlberg. All rights reserved.
//

import UIKit
import AVFoundation
import Vision


class CameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    @IBOutlet weak var unlockButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    
    let availableDevices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back).devices
    
    var correctCounter = 0
    
    var previewLayer = AVCaptureVideoPreviewLayer()
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Label"
        label.font = label.font.withSize(20)
        return label
    }()
    
    let correctLabel: UILabel = {
        let correctLabel = UILabel()
        correctLabel.textColor = .black
        correctLabel.translatesAutoresizingMaskIntoConstraints = false
        correctLabel.text = "Label"
        correctLabel.font = correctLabel.font.withSize(20)
        return correctLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        unlockButton.layer.cornerRadius = 15
        exitButton.layer.cornerRadius = 15
        
        view.addSubview(label)
        view.addSubview(correctLabel)
        
        setupCaptureSession()
        
        setupLabel()
        setupCorrectLabel()

        self.correctLabel.text = "Find a computer"
        
        
    }
    
    func setupCaptureSession() {
        
        // creates a new capture session
        let captureSession = AVCaptureSession()
        
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
        previewLayer.frame.size = CGSize(width: 600, height: 600)
        previewLayer.position = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2)
//        previewLayer.frame.size = innerView.frame.size
        //previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        view.layer.addSublayer(previewLayer)
//        previewLayer.isHidden = true
       
       
        
        captureSession.startRunning()
        
        captureOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let model = try? VNCoreMLModel(for: Resnet50().model) else { return }
        let request = VNCoreMLRequest(model: model) { (finishedRequest, error) in
            guard let results = finishedRequest.results as? [VNClassificationObservation] else { return }
            guard let Observation = results.first else { return }
            
            DispatchQueue.main.async(execute: {
                self.label.text = "\(Observation.identifier)"
 
                if self.label.text == "computer" || self.label.text == "desktop computer" || self.label.text == "laptop" || self.label.text == "computer keyboard" && self.correctCounter == 0 && self.correctLabel.text == "Find a computer" {
                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                    self.correctCounter += 1
                    self.correctLabel.text = "Find a cup"
                   
                }
                if self.label.text == "cup" || self.label.text == "espresso" || self.label.text == "coffee mug" || self.label.text == "teapot" && self.correctCounter == 1 && self.correctLabel.text == "Find a cup"{
                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                    self.correctCounter += 1
                    self.correctLabel.text = "Find a clock"
                    
                }
                if self.label.text == "analog clock" || self.label.text == "wall clock" || self.label.text == "stop watch" && self.correctCounter == 2{
                    AudioServicesPlayAlertSound(1519)
                    self.correctLabel.isHidden = true
                    self.previewLayer.isHidden = true
                    self.unlockButton.isHidden = false
                    self.label.isHidden = true
                }
              

            })
        }
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        // executes request
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    }
    
    func setupLabel() {
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
    }
    
    func setupCorrectLabel() {
        correctLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        correctLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
    }
    
}






