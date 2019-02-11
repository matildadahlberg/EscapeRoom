//
//  ViewController.swift
//  EscapeRoom
//
//  Created by Matilda Dahlberg on 2019-02-01.
//  Copyright © 2019 Matilda Dahlberg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var startButton: UIButton!
    
    var time = UILabel()
    var seconds = 0
    var minute = 0
    var gameTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.layer.cornerRadius = 15
        
        time.frame = CGRect(x: self.view.frame.width - 70, y: 40, width: 100, height: 20)
        self.view.addSubview(time)
        
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)

    }
    
    @objc func startTimer() {
        seconds += 1
        
        if seconds < 60 {
            time.text = "\(seconds)s"
        }
        
        if seconds == 60 {
            seconds = 0
            minute += 1
            time.text = "\(minute)m \(seconds)s"
        }
        
        if minute > 0 {
            time.text = "\(minute)m \(seconds)s"
        }
    }
    
    
    
    
    
    
    
}

