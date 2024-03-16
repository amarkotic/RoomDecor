import Core

enum LocalizableStrings: String {

    case addVirtualObject

    var localized: String {
        rawValue.localize(bundle: .module)
    }

}
