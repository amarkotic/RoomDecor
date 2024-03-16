import UIKit

extension UIImage {

    convenience init(with image: BundleImage) {
        self.init(named: image.rawValue, in: .module, with: .none)!
    }

    convenience init(systemImage: BundleSystemImage) {
        self.init(systemName: systemImage.rawValue)!
    }

}
