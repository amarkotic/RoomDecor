import SwiftUI
import Core

public enum LocalizableStrings: String {

    case addVirtualObject
    case scanTheRoom
    case share
    case moduleSwitchSlideToConfirm
    case start

    public var localized: String {
        rawValue.localize(bundle: .module)
    }

}
