import Foundation
import UIKit


protocol ShowsAlert {}

extension ShowsAlert where Self: UIViewController {
    
    func showAlert(title: String, segue : String) {
        let alert = UIAlertController(title: title, message: "You can now continue the breakout", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OKEY", style: .default, handler: { (_) in
            self.performSegue(withIdentifier: segue , sender: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
}








