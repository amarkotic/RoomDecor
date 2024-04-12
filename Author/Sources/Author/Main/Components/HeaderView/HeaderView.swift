import Combine
import UIKit
import CoreUi

class HeaderView: UIView {

    let defaultPadding: CGFloat = 8
    let socialImageSize = CGSize(width: 40, height: 40)

    var stackView: UIStackView!
    var titleLabel: UILabel!
    var textStackView: UIStackView!
    var nameLabel: UILabel!
    var roleLabel: UILabel!
    var imageStackView: UIStackView!
    var leadingButton: UIButton!
    var trailingButton: UIButton!
    var imageView: UIImageView!

    var leadingButtonTap: AnyPublisher<GesturePublisher.Output, Never> {
        leadingButton
            .throttledTap()
            .eraseToAnyPublisher()
    }

    var trailingButtonTap: AnyPublisher<GesturePublisher.Output, Never> {
        trailingButton
            .throttledTap()
            .eraseToAnyPublisher()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
