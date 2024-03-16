import Core

enum LocalizableStrings: String {

    case scanTheRoom

    var localized: String {
        rawValue.localize(bundle: .module)
    }

}
