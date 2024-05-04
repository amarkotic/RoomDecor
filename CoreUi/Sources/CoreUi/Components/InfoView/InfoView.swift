import UIKit

public class InfoView: UIView {

    let defaultPadding: CGFloat = 16
    let cornerRadius: CGFloat = 4
    let imageViewSize = CGSize(width: 20, height: 20)

    var stackView: UIStackView!
    var iconView: UIImageView!
    var labelView: UILabel!

    public override init(frame: CGRect) {
        super.init(frame: frame)

        buildViews()
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func set(title: String) {
        labelView.text = title
    }

}
