import Foundation

/**
 Formalizes resolving localizations in feature module oriented codebase.
 Implement this protocol when adding new localizable file in a feature module.
 */
public protocol Localizable {

    /**
     Gets localized string for provided localization key
     */
    var localized: String { get }

}

public extension String {

    /**
     Resolves localized text from provided bundle.
     - Parameters:
     - bundle: Bundle containing the text.
     - Returns: String localized to current system language.
     */
    var localize: String {
        NSLocalizedString(self, bundle: .main, comment: "")
    }

}
