/*
 * GradientView
 * This UIView extension is used to extend our UIView functionlities.
 * @category   SPPinView
 * @package    com.SPPinView
 * @version    1.0
 * @author     ssowri1
 * @copyright  Copyright (C) 2019 ssowri1. All rights reserved.
 */
import UIKit
extension UIView {
    /// To shake the view
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0]
        layer.add(animation, forKey: "shake")
    }
}
