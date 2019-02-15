//
//  PasswordViewController.swift
//  EscapeRoom
//
//  Created by Niklas Lindell on 2019-02-15.
//  Copyright © 2019 Matilda Dahlberg. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController, ShowsAlert {
    
    @IBOutlet weak var timeLabel: UILabel!
    var updateTimeLabel = Timer()
    let segue = "passwordSegue"

    override func viewDidLoad() {
        super.viewDidLoad()
        updateTimeLabel = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showAlert(title: "Correct!", segue: segue)
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
