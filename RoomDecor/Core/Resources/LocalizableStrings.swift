import SwiftUI

public enum LocalizableStrings: String {

    case addVirtualObject
    case scanTheRoom
    case share

    public var localized: String {
        rawValue.localize
    }

}
