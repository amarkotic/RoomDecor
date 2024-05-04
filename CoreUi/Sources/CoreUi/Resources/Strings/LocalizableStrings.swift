import Core

public enum LocalizableStrings: String {

    case scanTheRoom
    case save
    case share
    case moduleSwitchSlideToConfirm
    case start
    case author
    case confirm

    //Errors
    case errorTitle
    case roomScanSession
    case roomScanSave
    case roomScanLoad
    case virtualObjectSession
    case virtualObjectLoadObject

    public var localized: String {
        rawValue.localize(bundle: .module)
    }

}
