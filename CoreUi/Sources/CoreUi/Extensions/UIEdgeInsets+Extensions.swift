import UIKit
import Core

public extension UIEdgeInsets {

    static func insets(
        vertical: CGFloat = .zero,
        horizontal: CGFloat = .zero
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }

}
