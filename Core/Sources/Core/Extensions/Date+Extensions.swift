import Foundation

public extension Date {

    private static var currentDateTime: Date {
        Date()
    }

    static func formattedDate(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateTimeFormat.defaultDate.rawValue
        return dateFormatter.string(from: date)
    }

    static func formattedTime(from date: Date) -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = DateTimeFormat.defaultTime.rawValue
        return timeFormatter.string(from: date)
    }

    static var timestamp: String {
        let currentDate = formattedDate(from: currentDateTime)
        let currentTime = formattedTime(from: currentDateTime)
        return "\(currentDate)_\(currentTime)"
    }

}
