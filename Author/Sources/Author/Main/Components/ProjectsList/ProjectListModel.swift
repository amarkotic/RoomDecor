import UIKit

struct ProjectListModel {

    let title: String
    let description: String
    let items: [ProjectModel]

}

extension ProjectListModel {

    static var publishedProjectsModel: ProjectListModel {
        return ProjectListModel(
            title: LocalizableStrings.publishedProjectsTitle.localized,
            description: LocalizableStrings.publishedProjectsDescription.localized,
            items: [
                ProjectModel(
                    title: String(format: LocalizableStrings.role.localized, "iOS Lead"),
                    description: String(format: LocalizableStrings.appStoreRating.localized, "4.8"),
                    image: .phoenix,
                    url: ExternalLinks.phoenix.url),
                ProjectModel(
                    title: String(format: LocalizableStrings.role.localized, "iOS Engineer"),
                    description: String(format: LocalizableStrings.appStoreRating.localized, "5.0"),
                    image: .stylist,
                    url: ExternalLinks.stylist.url),
                ProjectModel(
                    title: String(format: LocalizableStrings.role.localized, "Owner"),
                    description: String(format: LocalizableStrings.appStoreRating.localized, "5.0"),
                    image: .roomDecor,
                    url: nil)])
    }

    static var notableProjectsModel: ProjectListModel {
        return ProjectListModel(
            title: LocalizableStrings.notableProjectsTitle.localized,
            description: LocalizableStrings.notableProjectsDescription.localized,
            items: [
                ProjectModel(
                    title: String(format: LocalizableStrings.role.localized, "Co-owner"),
                    description: String(format: LocalizableStrings.tech.localized, "IoT, OAuth2"),
                    image: .iotPolje),
                ProjectModel(
                    title: String(format: LocalizableStrings.role.localized, "iOS Engineer"),
                    description: String(format: LocalizableStrings.tech.localized, "WatchOS, WeatherKit, HealthKit"),
                    image: .fitSky),
                ProjectModel(
                    title: String(format: LocalizableStrings.role.localized, "iOS Intern"),
                    description: String(format: LocalizableStrings.tech.localized, "Combine, Realm"),
                    image: .movieApp),
                ProjectModel(
                    title: String(format: LocalizableStrings.role.localized, "Owner"),
                    description: String(format: LocalizableStrings.tech.localized, "First iOS product"),
                    image: .mOjo)])
    }

}
