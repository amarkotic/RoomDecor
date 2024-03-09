import UIKit

extension UIImage {

    convenience init(with image: Image) {
        self.init(named: image.rawValue)!
    }

}
