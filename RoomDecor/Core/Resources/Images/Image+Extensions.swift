import UIKit

extension UIImage {

    convenience init(with image: Image) {
        self.init(named: image.rawValue)!
    }

    convenience init(with systemImage: SystemImage) {
        self.init(systemName: systemImage.rawValue)!
    }

}
