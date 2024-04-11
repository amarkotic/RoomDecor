import UIKit
import Core

class ProjectCardView: UIView {

    let defaultPadding: CGFloat = 8
    let cornerRadius: CGFloat = 16

    var imageView: UIImageView!
    var stackView: UIStackView!
    var titleLabel: UILabel!
    var descriptionLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(viewModel: ProjectModel) {
        imageView.image = viewModel.image
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
    }

}
