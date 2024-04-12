import Core

enum LocalizableStrings: String {

    case meetTheAuthor
    case iosEngineer
    case name

    case technicalSkills
    case interpersonalSkills

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
