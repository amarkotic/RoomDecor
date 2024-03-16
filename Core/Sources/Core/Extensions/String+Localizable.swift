import Foundation

public extension String {

    func localize(bundle: Bundle) -> String {
        NSLocalizedString(self, bundle: bundle, comment: "")
    }

}
