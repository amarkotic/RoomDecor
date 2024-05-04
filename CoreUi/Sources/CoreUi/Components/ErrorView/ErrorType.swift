public enum ErrorType {

    case roomScanSession
    case roomScanSave
    case roomScanLoad
    case virtualObjectSession
    case virtualObjectLoadObject

    var description: String {
        switch self {
        case .roomScanSession:
            LocalizableStrings.roomScanSession.localized
        case .roomScanSave:
            LocalizableStrings.roomScanSave.localized
        case .roomScanLoad:
            LocalizableStrings.roomScanLoad.localized
        case .virtualObjectSession:
            LocalizableStrings.virtualObjectSession.localized
        case .virtualObjectLoadObject:
            LocalizableStrings.virtualObjectLoadObject.localized
        }
    }

}
