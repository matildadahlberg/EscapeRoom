//
//  PlaySoundViewController.swift
//  EscapeRoom
//
//  Created by Matilda Dahlberg on 2019-02-06.
//  Copyright © 2019 Matilda Dahlberg. All rights reserved.
//

import UIKit

class PlaySoundViewController: UIViewController {
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var unlockButton: UIButton!
    
    @IBOutlet weak var greenOutler: UIButton!
    @IBOutlet weak var blueOutlet: UIButton!
    @IBOutlet weak var orangeOutlet: UIButton!
    @IBOutlet weak var redOutlet: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exitButton.layer.cornerRadius = 15
        unlockButton.isHidden = true
    }
    
    @IBAction func greenButton(_ sender: Any) {
    }
    @IBAction func blueButton(_ sender: Any) {
    }
    
    @IBAction func orangeButton(_ sender: Any) {
    }
    
    @IBAction func redButton(_ sender: Any) {
    }
    
    
}
