//
//  CompassViewController.swift
//  EscapeRoom
//
//  Created by Niklas Lindell on 2019-02-05.
//  Copyright © 2019 Matilda Dahlberg. All rights reserved.
//

import UIKit

class CompassViewController: UIViewController {
    @IBOutlet weak var unlockButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        unlockButton.layer.cornerRadius = 15
        exitButton.layer.cornerRadius = 15
    }
    
   
    


}
