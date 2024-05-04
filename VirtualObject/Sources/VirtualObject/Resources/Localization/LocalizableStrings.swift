import Core

enum LocalizableStrings: String {

    case infoLabel
    case addVirtualObject

    case armchair
    case chair
    case smallShelf
    case lamp
    case sideTable
    case shelf
    case stool
    case table

    var localized: String {
        rawValue.localize(bundle: .module)
    }

}
