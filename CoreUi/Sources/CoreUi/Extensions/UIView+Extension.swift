import UIKit

public extension UIView {

    func roundAllCorners(withRadius radius: CGFloat, clipsToBounds: Bool = true) {
        layer.cornerRadius = radius
        layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner,
            .layerMaxXMaxYCorner,
            .layerMinXMaxYCorner]
        self.clipsToBounds = clipsToBounds
    }

    func addBorder(width: CGFloat = 1.0, color: UIColor = .black) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }

}
