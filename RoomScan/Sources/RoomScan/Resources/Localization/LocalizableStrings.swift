import Core

enum LocalizableStrings: String {

    case scanTheRoom
    case noLidarSupportPartOne
    case noLidarSupportPartTwo
    case noLidarSupportPartThree

    var localized: String {
        rawValue.localize(bundle: .module)
    }

}
