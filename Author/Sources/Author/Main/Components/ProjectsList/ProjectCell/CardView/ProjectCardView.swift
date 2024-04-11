import UIKit
import Core

class ProjectCardView: UIView {

    let defaultPadding: CGFloat = 16
    let cornerRadius: CGFloat = 16

    var stackView: UIStackView!
    var imageView: UIImageView!
    var titleLabel: UILabel!
    var roleLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(viewModel: ProjectModel) { }

}
