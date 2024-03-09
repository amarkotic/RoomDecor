import SwiftUI

public enum LocalizableStrings: String, Localizable {

    case addVirtualObject
    case scanTheRoom
    case share
    case moduleSwitchSlideToConfirm

    public var localized: String {
        rawValue.localize
    }

}
