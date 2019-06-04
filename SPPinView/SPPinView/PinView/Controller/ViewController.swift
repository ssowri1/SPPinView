/*
 * SPPinView
 * This SPPinView is main class to handle the examples passcode or pinview opertaions
 * @category   SPPinView
 * @package    com.SPPinView
 * @version    1.0
 * @author     ssowri1
 * @copyright  Copyright (C) 2019 ssowri1. All rights reserved.
 */
import UIKit
class ViewController: UIViewController {
    @IBOutlet weak var pinView: SPPinView!
    //MARK:- View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        changeAttributes()
    }
    //MARK:- Custom actions
    func changeAttributes() {
        /// Constraint to pinview charecter counts.
        pinView.pinCount = 4
        /// Change the password format whether it is a secure text or non sequre text.
        pinView.shouldSecureText = false
        /// Set the spacing of the password.
        pinView.spacing = 10
        /// To dismiss the keyboard
        pinView.becomeFirstResponder()
    }
    //MARK:- IB Actions
    @IBAction func editingEnd(_ sender: SPPinView) {
        if sender.pinString != "1111" {
            sender.shakePin()
        } else {
            sender.resignFirstResponder()
        }
    }
}
