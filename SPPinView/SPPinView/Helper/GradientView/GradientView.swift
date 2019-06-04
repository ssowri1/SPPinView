/*
 * GradientView
 * This GradientView is used to extend our gradient functionlities.
 * @category   SPPinView
 * @package    com.SPPinView
 * @version    1.0
 * @author     ssowri1
 * @copyright  Copyright (C) 2019 ssowri1. All rights reserved.
 */
import UIKit
class GradientView: UIView {
    //  gradine layer
    var gradientLayer: CAGradientLayer?
    class func layerClass() -> CAGradientLayer {
        return CAGradientLayer()
    }
    func gradientLay() -> CAGradientLayer {
        return gradientLayer!
    }
}
