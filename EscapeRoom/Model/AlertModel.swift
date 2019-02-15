import Foundation
import UIKit


protocol ShowsAlert {}

extension ShowsAlert where Self: UIViewController {
    
    func showAlert(title: String) {
        
        let alert = UIAlertController(title: title, message: "You can now continue the breakout", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OKEY", style: .default, handler: nil))
        
        
        present(alert, animated: true, completion: nil)
    }
}








