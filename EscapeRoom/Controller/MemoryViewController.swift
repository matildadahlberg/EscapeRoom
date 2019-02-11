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
    
    @IBAction func memoryCardPressed(_ sender: Any) {
        
        let button = sender as! UIButton
        
        switch button.tag {
        case 1:
            lionCard1.setImage(UIImage(named: "lion"), for: .normal)
        case 2:
            tigerCard1.setImage(UIImage(named: "tiger"), for: .normal)
        case 3:
            dogCard1.setImage(UIImage(named: "dog"), for: .normal)
        case 4:
            tigerCard2.setImage(UIImage(named: "tiger"), for: .normal)
        case 5:
            lionCard2.setImage(UIImage(named: "lion"), for: .normal)
        case 6:
            dogCard2.setImage(UIImage(named: "dog"), for: .normal)
        default:
            break
        }
        
        
        
        
    }
    
    
    
    
    
    
}
