import Core

enum LocalizableStrings: String {

    case addVirtualObject

    case armchair
    case chair
    case carpet
    case pouf
    case sideTable
    case sofa
    case table

    var localized: String {
        rawValue.localize(bundle: .module)
    }

}
