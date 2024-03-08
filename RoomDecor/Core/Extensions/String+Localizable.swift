import Foundation

public extension String {

    var localize: String {
        NSLocalizedString(self, bundle: .main, comment: "")
    }

}
