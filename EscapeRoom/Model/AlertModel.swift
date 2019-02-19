import Foundation
import UIKit


protocol ShowsAlert {}

extension ShowsAlert where Self: UIViewController {
    
    func showAlert(title: String, segue : String) {
        let alert = UIAlertController(title: title, message: "You can now continue the breakout", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OKEY", style: .default, handler: { (_) in
            self.performSegue(withIdentifier: segue , sender: nil)
        }))
        alert.view.tintColor = UIColor.black
        let myString  = "You can now continue the breakout"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font:UIFont(name: "TitilliumWeb-SemiBold", size: 18.0)!])
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSRange(location:0,length:myString.count))
        alert.setValue(myMutableString, forKey: "attributedMessage")
        alert.view.layer.cornerRadius = 50
        
        present(alert, animated: true, completion: nil)
    }
    
    func exitAlert() {
        let alert = UIAlertController(title: "", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "YES", style: .cancel, handler: { (_) in
            self.performSegue(withIdentifier: "exitSegue", sender: nil)
        }))
        alert.view.tintColor = UIColor.black
        let myString  = "Are you sure you want to give up?"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font:UIFont(name: "TitilliumWeb-SemiBold", size: 18.0)!])
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSRange(location:0,length:myString.count))
        alert.setValue(myMutableString, forKey: "attributedTitle")
        alert.addAction((UIAlertAction(title: "NO", style: .default, handler: nil)))
        present(alert, animated: true, completion: nil)
    }
 
}








