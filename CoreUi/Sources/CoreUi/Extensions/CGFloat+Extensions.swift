import Foundation

public extension CGFloat {

    static let defaultPadding: CGFloat = 8
    static let doublePadding: CGFloat = .padding(withMultiplier: 2)

    static func padding(_ baseValue: CGFloat = defaultPadding, withMultiplier multiplier: CGFloat = 1.0) -> CGFloat {
        baseValue * multiplier
    }

}
