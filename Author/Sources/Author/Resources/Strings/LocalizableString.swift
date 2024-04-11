import Core

enum LocalizableStrings: String {

    case publishedProjectsTitle
    case publishedProjectsDescription

    case notableProjectsTitle
    case notableProjectsDescription

    case role
    case tech
    case appStoreRating

    var localized: String {
        rawValue.localize(bundle: .module)
    }

}
