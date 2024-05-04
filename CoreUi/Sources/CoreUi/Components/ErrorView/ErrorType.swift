public enum ErrorType {

    case roomScanSession
    case roomScanSave
    case roomScanLoad
    case virtualObjectSession
    case virtualObjectLoadObject

    var title: String { "We've run into an issue!" }

    var description: String {
        switch self {
        case .roomScanSession:
            "Room scan didn't manage to recognize objects. Please try again and move your phone slowley."
        case .roomScanSave:
            "Room scan can't be saved at the moment. Please try to scan the room once again."
        case .roomScanLoad:
            "Room scans you are trying to access don't seem to be available. Please restart the app and try again."
        case .virtualObjectSession:
            "Virtual object session can't be started at the moment. Please restart the app and try again."
        case .virtualObjectLoadObject:
            "Virtual object you are trying to load doesn't seem to be available. Please restart the app and try again."
        }
    }

}
