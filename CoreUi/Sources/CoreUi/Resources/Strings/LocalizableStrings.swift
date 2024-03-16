import Core

public enum LocalizableStrings: String {

    case scanTheRoom
    case share
    case moduleSwitchSlideToConfirm
    case start

    public var localized: String {
        rawValue.localize(bundle: .module)
    }

}
