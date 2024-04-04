import UIKit

public extension UIFont {

    convenience init(with bundleFont: BundleFont, size: CGFloat) {
        self.init(name: bundleFont.rawValue, size: size)!
    }

}
