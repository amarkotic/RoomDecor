import Foundation

public enum ExternalLinks: String {

    case phoenix = "https://apps.apple.com/us/app/the-phoenix-a-sober-community/id1513232300"
    case stylist = "https://apps.apple.com/us/app/j-hilburn-stylist/id6446250506"

    public var url: URL? {
        URL(string: self.rawValue)
    }

}
