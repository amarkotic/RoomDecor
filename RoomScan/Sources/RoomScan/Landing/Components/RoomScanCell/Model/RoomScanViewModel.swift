import Foundation
import Core

struct RoomScanViewModel: Hashable {

    let url: URL

    var extractedDateTime: Date? {
        let dateTimePart = url.deletingPathExtension().lastPathComponent.replacingOccurrences(of: "scan_", with: "")
        return Date.decode(from: dateTimePart, using: .fullDateTime)
    }

    var dateString: String {
        guard let date = extractedDateTime else { return "N/A" }
        return Date.format(date, using: .defaultDate)
    }

    var timeString: String {
        guard let date = extractedDateTime else { return "N/A" }
        return Date.format(date, using: .defaultTime)
    }

}
