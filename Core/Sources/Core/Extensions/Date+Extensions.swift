import Foundation

public extension Date {

    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()

    // Function to format a Date object
    static func format(_ date: Date, using format: DateTimeFormat) -> String {
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: date)
    }

    // Function to decode a string to a Date object
    static func decode(from dateString: String, using format: DateTimeFormat) -> Date? {
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.date(from: dateString)
    }

}
