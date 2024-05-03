import Core

public enum LocalizableStrings: String {

    case scanTheRoom
    case save
    case share
    case moduleSwitchSlideToConfirm
    case start
    case author

    public var localized: String {
        rawValue.localize(bundle: .module)
    }

}
