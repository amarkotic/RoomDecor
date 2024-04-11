import Combine
import UIKit
import CoreUi

class HeaderView: UIView {

    let defaultPadding: CGFloat = 8

    var stackView: UIStackView!
    var textStackView: UIStackView!
    var nameLabel: UILabel!
    var roleLabel: UILabel!
    var imageView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
