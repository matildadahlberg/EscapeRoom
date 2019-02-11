//
//  MemoryViewController.swift
//  EscapeRoom
//
//  Created by Matilda Dahlberg on 2019-02-08.
//  Copyright © 2019 Matilda Dahlberg. All rights reserved.
//

import UIKit

class MemoryViewController: UIViewController {

    @IBOutlet weak var exitButton: UIButton!
    
    
    @IBOutlet weak var unlockButton: UIButton!
    
    @IBOutlet weak var lionCard1: UIButton!
    @IBOutlet weak var tigerCard1: UIButton!
    @IBOutlet weak var dogCard1: UIButton!
    @IBOutlet weak var tigerCard2: UIButton!
    @IBOutlet weak var lionCard2: UIButton!
    @IBOutlet weak var dogCard2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        exitButton.layer.cornerRadius = 15
        unlockButton.isHidden = true
    }
    
    @IBAction func lionCardButton1(_ sender: Any) {
        lionCard1.setImage(UIImage(named: "lion"), for: .normal)
    }
    
    
    @IBAction func tigerCardButton1(_ sender: Any) {
        tigerCard1.setImage(UIImage(named: "tiger"), for: .normal)
    }
    
    @IBAction func dogCardButton(_ sender: Any) {
        dogCard1.setImage(UIImage(named: "dog"), for: .normal)
    }
    
    @IBAction func tigerCardButton2(_ sender: Any) {
        tigerCard2.setImage(UIImage(named: "tiger"), for: .normal)
    }
    
    @IBAction func lionCardButton2(_ sender: Any) {
        lionCard2.setImage(UIImage(named: "lion"), for: .normal)
    }
    
    @IBAction func dogCardButton2(_ sender: Any) {
        dogCard2.setImage(UIImage(named: "dog"), for: .normal)
    }
    

}
