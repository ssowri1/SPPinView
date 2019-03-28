/*
 * AppDelegate
 * This SPPinView is handle all the process of our pin view features.
 * @category   SPPinView
 * @package    com.SPPinView
 * @version    1.0
 * @author     ssowri1
 * @copyright  Copyright (C) 2019 ssowri1. All rights reserved.
 */
import UIKit
@IBDesignable
class SPPinView: UIControl, UIKeyInput {
    // To clear respective pinview texts which user tapped on.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        clear()
        becomeFirstResponder()
    }
    // to design how many number of pins would be shown
    @IBInspectable var pinCount: Int = 4 {
        didSet {
            setupViews()
            setNeedsDisplay()
        }
    }
    // to spacing between the pins
    @IBInspectable var spacing: CGFloat = 10 {
        didSet {
            pinStack.spacing = spacing
            setupViews()
            layoutIfNeeded()
        }
    }
    //
    // to hide the texts by enable true
    //
    @IBInspectable var shouldSecureText: Bool = false {
        didSet {
            setupViews()
            layoutIfNeeded()
        }
    }
    // to change the font of pins
    @IBInspectable var pinFont: UIFont = UIFont(name: "Futura-Medium", size: 21)! {
        didSet {
            setupViews()
            layoutIfNeeded()
        }
    }
    // to shake and clear if the pin is invalid
    public func shakePin() {
        clear()
        shake()
    }
    // to check whether it contains text or not
    var hasText: Bool {
        return nextTag > 1 ? true : false
    }
    // to print the entire pin at end of the editing
    var pinString: String = ""
    func insertText(_ text: String) {
        var secureText = text
        if shouldSecureText {
            secureText = "•"
        }
        if nextTag < (pinCount + 1) {
            (viewWithTag(nextTag)! as! PinView).key = text
            (viewWithTag(nextTag)! as! PinView).text = secureText
            (viewWithTag(nextTag)! as! PinView).font = pinFont
            nextTag += 1
            if nextTag == (pinCount + 1) {
                pinString = ""
                for index in 1..<nextTag {
                    pinString += (viewWithTag(index)! as! PinView).key
                }
                sendActions(for: .editingDidEnd)
            }
        }
    }
    // to delete the pins
    func deleteBackward() {
        if nextTag > 1 {
            nextTag -= 1
            (viewWithTag(nextTag)! as! PinView).key = ""
            (viewWithTag(nextTag)! as! PinView).text = ""
        }
    }
    func clear() {
        while nextTag > 1 {
            deleteBackward()
        }
    }
    // to change the keyboard type
    var keyboardType: UIKeyboardType {
        get {
            return .numberPad
        }
        set { }
    }
    // to identify the every pin with tag value
    private var nextTag = 1
    private lazy var pinStack: UIStackView = {
        let stv = UIStackView.init()
        stv.axis = .horizontal
        stv.alignment = .center
        stv.translatesAutoresizingMaskIntoConstraints = false
        stv.distribution = .fill
        stv.spacing = spacing
        return stv
    }()
    override var canBecomeFirstResponder: Bool {
        return true
    }
    // for dynamic initialisation
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViewToThisControl()
        self.setupViews()
    }
    // for storyboard initialisation
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubViewToThisControl()
        self.setupViews()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        addSubViewToThisControl()
        self.setupViews()
    }
    private func addSubViewToThisControl() {
        addSubview(pinStack)
    }
    // to configure the view elements
    func setupViews() {
        for pinView in pinStack.arrangedSubviews {
            pinView.removeFromSuperview()
        }
        for cons in constraints {
            if cons.firstAttribute == .width {
                cons.isActive = false
            }
        }
        layoutIfNeeded()
        for tag in 1...pinCount {
            let pin = PinView.init(frame: .zero)
            pin.tag = tag
            pin.translatesAutoresizingMaskIntoConstraints = false
            pinStack.addArrangedSubview(pin)
        }
        addConstraints([
            pinStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            pinStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            pinStack.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7, constant: 0),
            pinStack.widthAnchor.constraint(equalTo: pinStack.heightAnchor, multiplier: CGFloat(pinCount), constant: (CGFloat(pinCount - 1) * spacing)),
            ])
        for pinn in pinStack.arrangedSubviews {
            guard let pin = pinn as? PinView else {return}
            pinStack.addConstraints([
                pin.heightAnchor.constraint(equalTo: pinStack.heightAnchor, multiplier: 1),
                pin.widthAnchor.constraint(equalTo: pin.heightAnchor, constant: 0)
                ])
        }
    }
    // private class of UITextField pin view
    private class PinView: UITextField {
        var key: String = "" {
            didSet {
                setupViews()
            }
        }
        var hassText: Bool {
            return key != ""
        }
        override var bounds: CGRect {
            didSet {
                setupViews()
            }
        }
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupViews()
        }
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        private func setupViews() {
            layer.cornerRadius = 5
            layer.masksToBounds = true
            backgroundColor = .lightGray
            textAlignment = .center
            textColor = .white
            isUserInteractionEnabled = false
            font = self.font
            if hassText {
                self.backgroundColor = .blue
            } else {
                self.layer.borderColor = UIColor.white.cgColor
            }
        }
    }
}
