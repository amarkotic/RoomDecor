import Foundation

public extension String {

    /**
     Resolves localized text from provided bundle.
     - Parameters:
     - bundle: Bundle containing the text.
     - Returns: String localized to current system language.
     */
    func localize(bundle: Bundle) -> String {
        NSLocalizedString(self, bundle: bundle, comment: "")
    }

}
