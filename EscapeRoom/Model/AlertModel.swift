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
    
    func exitAlert() {
        let alert = UIAlertController(title: "Are you sure you want to give up?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "YES", style: .cancel, handler: { (_) in
            self.performSegue(withIdentifier: "exitSegue", sender: nil)
        }))
        alert.addAction((UIAlertAction(title: "NO", style: .default, handler: nil)))
        present(alert, animated: true, completion: nil)
    }
 
}








