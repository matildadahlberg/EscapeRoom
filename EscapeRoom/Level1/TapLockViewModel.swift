//
//  TapLockViewModel.swift
//  EscapeRoom
//
//  Created by Niklas Lindell on 2019-04-02.
//  Copyright © 2019 Matilda Dahlberg. All rights reserved.
//

import Foundation
import AVFoundation

class TapLockViewModel {
    
    enum Image {
        case key1
        case key2
    }
    
    var tapped = 0
    let segue = "lockSegue"
    
    var onImageChanged: ((Image) -> Void)? = nil
    
    
    func buttonPressed() {
        
        tapped += 1
        AudioServicesPlayAlertSound(1519)
//        UIView.animate(withDuration: 0) {
//            self.progressView.value = CGFloat(self.tapped)
//        }
        
        if tapped % 2 == 0 {
            onImageChanged?(.key2)
        }
        
        if tapped % 2 != 0 {
           onImageChanged?(.key1)
        }
        
        if tapped == 20 {
            print("YOU WON")
        }
    }
    
    
  
    
    
    

    
    
    
   
    
    
    
    
    
    
    
}
