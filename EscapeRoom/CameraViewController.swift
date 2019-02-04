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
    
    let availableDevices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back).devices
    
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Label"
        label.font = label.font.withSize(30)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(label)
        
        setupCaptureSession()
        
        setupLabel()
        
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
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.frame
        view.layer.addSublayer(previewLayer)
        
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
    
    
    
    
    
}
