import SwiftUI

public enum LocalizableStrings: String, Localizable {

    case addVirtualObject
    case scanTheRoom
    case share
    case moduleSwitchSlideToConfirm
    case start

    public var localized: String {
        rawValue.localize
    }

}
