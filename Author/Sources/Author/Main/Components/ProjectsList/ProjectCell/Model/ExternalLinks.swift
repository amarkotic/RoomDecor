import Foundation

public enum ExternalLinks: String {

    case linkedin = "https://www.linkedin.com/in/antonio-markotić-673735174/"
    case github = "https://github.com/amarkotic"
    case phoenix = "https://apps.apple.com/us/app/the-phoenix-a-sober-community/id1513232300"
    case stylist = "https://apps.apple.com/us/app/j-hilburn-stylist/id6446250506"

    public var url: URL? {
        URL(string: self.rawValue)
    }

}
