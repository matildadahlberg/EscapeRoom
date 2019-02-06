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
    override func viewDidLoad() {
        super.viewDidLoad()
        exitButton.layer.cornerRadius = 15
        unlockButton.isHidden = true
    }
    
    
}
