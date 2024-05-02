import UIKit

class NotificationView: UIView {

    let defaultPadding: CGFloat = 8
    let cornerRadius: CGFloat = .doublePadding

    var stackView: UIStackView!
    var labelOne: UILabel!
    var labelTwo: UILabel!
    var labelThree: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
